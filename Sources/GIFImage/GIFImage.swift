//
//  GIFImage.swift
//  GIFImage
//
//  Created by Christopher Lowiec on 07/08/2021.
//

import SwiftUI

#if os(iOS)
@available(iOS 13, *)
public struct GIFImage: UIViewRepresentable {
    
    // MARK: - Stored Properites
    
    private var gifName: String
    
    // MARK: - Initialization
    
    public init(gifName: String) {
        self.gifName = gifName
    }
    
    // MARK: - Methods
    
    public func updateUIView(
        _ uiView: UIView,
        context: UIViewRepresentableContext<GIFImage>
    ) {}
    
    public func makeUIView(context: Context) -> UIView {
        GIFPlayer(gifName: gifName)
    }
    
}
#elseif os(macOS)
@available(macOS 10.15, *)
public struct GIFImage: NSViewRepresentable {
    
    // MARK: - Stored Properites
    
    private var gifName: String
    
    // MARK: - Initialization
    
    public init(gifName: String) {
        self.gifName = gifName
    }
    
    // MARK: - Methods
    
    public func updateNSView(
        _ nsView: NSView,
        context: NSViewRepresentableContext<GIFImage>
    ) {}
    
    public func makeNSView(context: Context) -> NSView {
        GIFPlayer(gifName: gifName)
    }
    
}
#endif
