//
//  UIImage+GIF.swift
//  GIFImage
//
//  Created by Christopher Lowiec on 07/08/2021.
//

import SwiftUI

#if os(iOS)
extension UIImage {
    
    // MARK: - Create GIF Image
    
    public class func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Source for the image does not exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gif(url: String) -> UIImage? {
        guard let bundleURL = URL(string: url) else {
            print("This image named \"\(url)\" does not exist")
            return nil
        }
        
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    public class func gif(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
                print("This image named \"\(name)\" does not exist")
                return nil
        }
        
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    public class func gif(asset: String) -> UIImage? {
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }
        
        return gif(data: dataAsset.data)
    }
    
    // MARK: - GIF animation
    
    internal class func delayForImageAtIndex(
        _ index: Int,
        source: CGImageSource!
    ) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
            return delay
        }
        
        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(
                gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()
            ),
            to: AnyObject.self
        )
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(
                CFDictionaryGetValue(
                    gifProperties,
                    Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()
                ),
                to: AnyObject.self
            )
        }
        
        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            delay = 0.1
        }
        
        return delay
    }
    
    internal class func gcdForPair(
        _ lhs: Int?,
        _ rhs: Int?
    ) -> Int {
        var lhs = lhs
        var rhs = rhs
        if rhs == nil || lhs == nil {
            if rhs != nil {
                return rhs!
            } else if lhs != nil {
                return lhs!
            } else {
                return 0
            }
        }
        
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }
        
        var rest: Int
        while true {
            rest = lhs! % rhs!
            
            if rest == 0 {
                return rhs!
            } else {
                lhs = rhs
                rhs = rest
            }
        }
    }
    
    internal class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for index in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(
                Int(index),
                source: source
            )
            delays.append(Int(delaySeconds * 1000.0))
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(
            with: frames,
            duration: Double(duration) / 1000.0
        )
        
        return animation
    }
    
}
#elseif os(macOS)
extension NSImage {
    
    // MARK: - Create GIF Image
    
    public class func gif(data: Data) -> NSImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Source for the image does not exist")
            return nil
        }
        
        return NSImage.animatedImageWithSource(source)
    }
    
    public class func gif(url: String) -> NSImage? {
        guard let bundleURL = URL(string: url) else {
            print("This image named \"\(url)\" does not exist")
            return nil
        }
        
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    public class func gif(name: String) -> NSImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
                print("This image named \"\(name)\" does not exist")
                return nil
        }
        
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    public class func gif(asset: String) -> NSImage? {
        if #available(macOS 10.11, *) {
            guard let dataAsset = NSDataAsset(name: asset) else {
                print("Cannot turn image named \"\(asset)\" into NSDataAsset")
                return nil
            }
            
            return gif(data: dataAsset.data)
        } else {
            return gif(data: Data(base64Encoded: asset) ?? Data())
        }
    }
    
    // MARK: - GIF animation
    
    internal class func delayForImageAtIndex(
        _ index: Int,
        source: CGImageSource!
    ) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
            return delay
        }
        
        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(
                gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()
            ),
            to: AnyObject.self
        )
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(
                CFDictionaryGetValue(
                    gifProperties,
                    Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()
                ),
                to: AnyObject.self
            )
        }
        
        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            delay = 0.1
        }
        
        return delay
    }
    
    internal class func gcdForPair(
        _ lhs: Int?,
        _ rhs: Int?
    ) -> Int {
        var lhs = lhs
        var rhs = rhs
        if rhs == nil || lhs == nil {
            if rhs != nil {
                return rhs!
            } else if lhs != nil {
                return lhs!
            } else {
                return 0
            }
        }
        
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }
        
        var rest: Int
        while true {
            rest = lhs! % rhs!
            
            if rest == 0 {
                return rhs!
            } else {
                lhs = rhs
                rhs = rest
            }
        }
    }
    
    internal class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = NSImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    internal class func animatedImageWithSource(_ source: CGImageSource) -> NSImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for index in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }
            
            let delaySeconds = NSImage.delayForImageAtIndex(
                Int(index),
                source: source
            )
            delays.append(Int(delaySeconds * 1000.0))
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [NSImage]()
        
        var frame: NSImage
        var frameCount: Int
        for index in 0..<count {
            frame = NSImage(cgImage: images[Int(index)], size: .zero)
            frameCount = Int(delays[Int(index)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        
        let sequenceLayer = image(sequence: frames, duration: Double(duration) / 1000.0)
        let image = NSImageView()
        image.layer = sequenceLayer
        
        return image.image
    }
    
    internal class func image(sequence: [NSImage], duration: CFTimeInterval? = nil, frame: CGRect? = nil) -> CALayer {

        let layer = CALayer()
        if let f = frame { layer.frame = f }
        layer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]

        let keyPath = "contents"

        let keyFrameAnimation = CAKeyframeAnimation(keyPath: keyPath)
        keyFrameAnimation.values = sequence
        keyFrameAnimation.calculationMode = .discrete
        keyFrameAnimation.fillMode = .forwards
        keyFrameAnimation.duration = duration ?? CFTimeInterval(sequence.count / 18)
        keyFrameAnimation.repeatCount = Float.infinity
        keyFrameAnimation.autoreverses = false
        keyFrameAnimation.isRemovedOnCompletion = false
        keyFrameAnimation.beginTime = 0.0

        layer.add(keyFrameAnimation, forKey: keyPath)

        return layer

    }
    
}
#endif
