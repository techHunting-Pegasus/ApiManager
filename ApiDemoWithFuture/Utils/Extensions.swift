//
//  Extensions.swift
//  Coravida
//
//  Created by Sachtech on 12/04/19.
//  Copyright © 2019 Chanpreet Singh. All rights reserved.
//

import Foundation
import UIKit
import AVKit


//MARK:- UIApplication Extension
extension UIApplication {
    
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var statusBarUIView: UIView? {
      if #available(iOS 13.0, *) {
          let tag = 38482
          let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

          if let statusBar = keyWindow?.viewWithTag(tag) {
              return statusBar
          } else {
              guard let statusBarFrame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame else { return nil }
              let statusBarView = UIView(frame: statusBarFrame)
              statusBarView.tag = tag
              keyWindow?.addSubview(statusBarView)
              return statusBarView
          }
      } else if responds(to: Selector(("statusBar"))) {
          return value(forKey: "statusBar") as? UIView
      } else {
          return nil
      }
    }
}

//MARK:- Date Extension
extension Date{
    
    func getFormattedDate(_ format:String = "yyyy-MM-dd HH:mm:ss") -> String{
        let formatter = DateFormatter()
        formatter.locale =  Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    static var timeStamp: Int64{
        return Int64(Date().timeIntervalSince1970)
    }
}

//MARK:- String Extension
extension String{
    
    func getFormattedDate(format: String) -> String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT-07")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let yourDate = formatter.date(from: self)
        formatter.dateFormat = format
        let getDate = formatter.string(from: yourDate ?? Date())
        return getDate
    }
    
    func toDate()->Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yyyy hh:mm a"
        let newDate = formatter.date(from: self) ?? Date()
        return newDate
    }

    
    var boolValue: Bool {
        return self == "1" ? true : false
    }
    
    func base64Encoded() -> String{
        let stringData = self.data(using: .utf8) ?? Data()
        let encodedStr = stringData.base64EncodedString()
        return encodedStr
    }
    func base64Decoded() -> String{
        let data = Data(base64Encoded: self) ?? Data()
        let decodedStr = String(data: data, encoding: .utf8) ?? ""
        return decodedStr
    }

    var toData: Data?{
        return Data(base64Encoded: self)
    }
}

//MARK:- UIImage Extension
extension UIImage {
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    // MARK: - Image Scaling.
    
    /// Represents a scaling mode
    enum ScalingMode {
        case aspectFill
        case aspectFit
        
        /// Calculates the aspect ratio between two sizes
        ///
        /// - parameters:
        ///     - size:      the first size used to calculate the ratio
        ///     - otherSize: the second size used to calculate the ratio
        ///
        /// - return: the aspect ratio between the two sizes
        func aspectRatio(between size: CGSize, and otherSize: CGSize) -> CGFloat {
            let aspectWidth  = size.width/otherSize.width
            let aspectHeight = size.height/otherSize.height
            
            switch self {
            case .aspectFill:
                return max(aspectWidth, aspectHeight)
            case .aspectFit:
                return min(aspectWidth, aspectHeight)
            }
        }
    }
    
    /// Scales an image to fit within a bounds with a size governed by the passed size. Also keeps the aspect ratio.
    ///
    /// - parameter:
    ///     - newSize:     the size of the bounds the image must fit within.
    ///     - scalingMode: the desired scaling mode
    ///
    /// - returns: a new scaled image.
    func scaled(to newSize: CGSize, scalingMode: UIImage.ScalingMode = .aspectFill) -> UIImage {
        
        let aspectRatio = scalingMode.aspectRatio(between: newSize, and: size)
        
        /* Build the rectangle representing the area to be drawn */
        var scaledImageRect = CGRect.zero
        
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
        
        /* Draw and retrieve the scaled image */
        UIGraphicsBeginImageContext(newSize)
        
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
    
}

//MARK:- Double Extension
extension Double{
    func timestampToDate() -> Date{
        let date = Date(timeIntervalSince1970: self)
        return date
    }
    
    func toMinSec() -> String{
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func getReadingLevel() -> (String, UIColor?){
        if self >= 0 && self < 0.5{
            return ("Negative",UIColor(named: "testNegative"))
        }
        else if self >= 0.5 && self < 1.5{
            return ("Trace",UIColor(named: "testTrace"))
        }
        else if self >= 1.5 && self < 4{
            return ("Small",UIColor(named: "testSmall"))
        }
        else if self >= 4 && self < 8{
            return ("Moderate",UIColor(named: "testModerate"))
        }
        else if self >= 8 && self < 16{
            return ("Large",UIColor(named: "testLarge"))
        }else{
            return ("Larger",UIColor(named: "testLarger"))
        }
    }
    
}

extension Int64{
    func timestampToDate() -> Date{
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date
    }
    func calculateDataSize() -> String{
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useBytes,.useKB,.useMB,.useGB]
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(self))
        return string
    }
    func convertSecondsToTimeFormats(format: String = "TTT") -> String{
        let days = Int64(self) / 86400
        let hours = Int64(self) % 86400 / 3600
        let minutes = Int64(self) / 60 % 60
        let seconds = Int64(self) % 60
        var stringArr = ""
        if days != 0{
            stringArr = days == 1 ? "\(days) Day" : "\(days) Days"
        }
        else if hours != 0{
            stringArr = hours == 1 ? "\(hours) Hour" : "\(hours) Hours"
        }
        else if minutes != 0{
            stringArr = minutes == 1 ? "\(minutes) Minute" : "\(minutes) Minutes"
        }
        else if seconds != 0{
            stringArr = seconds == 1 ? "\(seconds) Second" : "\(seconds) Seconds"
        }else{
             stringArr = "Off"
        }
        if format == "T"{
            let strArr = stringArr.split(separator: " ")
            if strArr.count > 1{
                let num = String(strArr[0])
                var day = String(strArr[1].prefix(1))
                day = day == "D" ? day : day.lowercased()
                let dayArr = [num,day]
                return dayArr.joined(separator: " ")
            }else{
               return stringArr
            }
        }else{
            return stringArr
        }
    }
    

}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
    var stringValue: String {
        return self ? "true" : "false"
    }
    
    var numStringValue: String{
       return self ? "1" : "0"
    }
}

extension UIView{
    func addBlurEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

extension URL {
    func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).last {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    print(error.localizedDescription)
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
    }
}


extension String {
    var utf8String:UnsafePointer<Int8>? {
        return (self as NSString).utf8String
    }
}

extension Int {
    var boolValue: Bool {
        return self != 0
    }
}

extension Data{
    var toString: String{
        return self.base64EncodedString()//String(bytes: self, encoding: .utf8) ?? ""
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
extension Date {


    func getMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: Date())
       }
    func getMonthFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
       }
    
    func getMonth2Digit() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
       }
    func getMonth3Digit() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
       }


    
    func getPreviousDate() -> Date {
            var components = DateComponents()
            components.day = -1
            return Calendar.current.date(byAdding: components, to:Date())!
        }
    func getPreviousMonth() -> Date {
            var components = DateComponents()
            components.month = -1
            return Calendar.current.date(byAdding: components, to:Date())!
        }
    func getPreviousYear() -> Date {
            var components = DateComponents()
            components.year = -1
            return Calendar.current.date(byAdding: components, to:Date())!
        }
    
    func getTime(_ format:String = "h:mm a") -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getTimeWithSecond(_ format:String = "HH:mm:ss") -> String{
        let formatter = DateFormatter()
        formatter.locale =  Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getTodayDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    func getFormationDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: self)
    }
    func getFormationMonth() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-yyyy"
        return formatter.string(from: self)
    }
    
    func getFormationYear() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
    
    
    
}
extension Date
{
  mutating func addDays(n: Int)
  {
      let cal = Calendar.current
      self = cal.date(byAdding: .day, value: n, to: self)!
  }
  

  func firstDayOfTheMonth() -> Date {
      return Calendar.current.date(from:
          Calendar.current.dateComponents([.year,.month], from: self))!
  }
  func getDay() -> String{
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat  = "EE" // "EE" to get short style
      return dateFormatter.string(from: self) // "Sunday"
  }
  func getDate() -> String{
      let formatter = DateFormatter()
      //2016-12-08 03:37:22 +0000
      formatter.dateFormat = "dd"
      return  formatter.string(from:self)
  }
    
    func getHealthyDate() -> String{
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd"
        return  formatter.string(from:self)
    }
  func getAllDays() -> [Date]
  {
      var days = [Date]()

      let calendar = Calendar.current

      let range = calendar.range(of: .day, in: .month, for: self)!

      var day = startOfMonth()
//        day.addDays(n: 1)

      for _ in 1...range.count
      {
          print(day)
          days.append(day)
          day.addDays(n: 1)
      }

      return days
  }
}
extension Date {
  func startOfMonth() -> Date {
      return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))! + 1
  }

  func endOfMonth() -> Date {
      return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
  }
}

extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))


        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}

//with this extension you dont need to do this URL("https:/google.com") you can directly do this now
// let url:URL = "google.com"
extension URL:ExpressibleByStringLiteral{
    public init(stringLiteral value: StaticString) {
        self.init(string: "\(value)")!
    }
}

//by this extension if you try to access array out of bonds it will send you nil not crash the app
//use it as data[safe:5]
extension Collection{
    subscript(safe index:Index) -> Element?{
        return indices.contains(index) ? self[index]:nil
    }
}

//just user optional.orEmpty to get "" if its nil
extension Optional where Wrapped == String{
    var orEmpty:String{
        switch self {
        case .some(let value):
            return value
        case .none:
            return ""
        }
    }
}
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

//use for  loop with where condition
//for number in numbers where number.isMultiple(of:2){
//   print(number)
//}

@propertyWrapper
struct UserDefault<Value>{
    let key:String
    let defaultValue:Value
    
    init(key:String,defaultValue:Value){
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue:Value{
        get{
            UserDefaults.standard.object(forKey: self.key) as? Value ?? self.defaultValue
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: self.key)
        }
    }
    
    var projectedValue:Self{
        get{
            return self
        }
    }
    
    func removeValue(){
        UserDefaults.standard.removeObject(forKey: self.key)
    }
}


struct UserDefaultValues{
    @UserDefault(key: "hasSeenAppIntro", defaultValue: false)
    static var hasSeenAppIntro:Bool
    
    
}



extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600000)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}


extension Array {
    func unique<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        var set = Set<T>()
        return self.reduce(into: [Element]()) { result, value in
            guard !set.contains(value[keyPath: keyPath]) else {
                return
            }
            set.insert(value[keyPath: keyPath])
            result.append(value)
        }
    }
}
