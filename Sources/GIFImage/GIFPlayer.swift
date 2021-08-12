//
//  GIFPlayer.swift
//  GIFImage
//
//  Created by Christopher Lowiec on 07/08/2021.
//

import SwiftUI

#if os(iOS)
final class GIFPlayer: UIView {
    
    // MARK: - Stored Properites
    
    private let gifImageView = UIImageView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(gifName: String) {
        self.init()
        
        let gif = UIImage.gif(name: gifName)
        gifImageView.image = gif
        gifImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gifImageView.frame = bounds
        gifImageView.backgroundColor = .clear
        addSubview(gifImageView)
    }
    
}
#elseif os(macOS)
final class GIFPlayer: NSView {
    
    // MARK: - Stored Properites
    
    private let gifImageView = NSImageView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(gifName: String) {
        self.init()
        
        let gif = NSImage.gif(name: gifName)
        gifImageView.image = gif
        gifImageView.imageAlignment = .alignCenter
    }
    
    // MARK: - Methods
    
    override func layout() {
        super.layout()
        
        gifImageView.frame = bounds
        addSubview(gifImageView)
    }
    
}
#endif
