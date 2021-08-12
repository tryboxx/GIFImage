//
//  UIImageView+GIFLoader.swift
//  GIFImage
//
//  Created by Christopher Lowiec on 07/08/2021.
//

import SwiftUI

#if os(iOS)
extension UIImageView {
    
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
    }
    
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            
            DispatchQueue.main.async {  [weak self] in
                self?.image = image
            }
        }
    }
    
}

#elseif os(macOS)
extension NSImageView {
    
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = NSImage.gif(name: name)
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
    }
    
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = NSImage.gif(asset: asset)
            
            DispatchQueue.main.async {  [weak self] in
                self?.image = image
            }
        }
    }
    
}
#endif
