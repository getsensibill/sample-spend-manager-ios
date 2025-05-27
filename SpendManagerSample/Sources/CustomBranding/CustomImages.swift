//
//  CustomImages.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-16.
//

import Sensibill
import UIKit

/// Demonstrates the implementation of `BrandingFontsProvider`
class CustomImages: BrandingImagesProvider {
    
    /// Branding images could be defined elsewhere, and in any way (e.g. constants, resources)
    private enum Images {
        static let close = "arrowshape.backward.fill"
        static let info = "info.circle"
    }
    
    // MARK: - Define Branding Images
    
    // In this sample we are replacing icons for some capture buttons
    // For all other icons, default images will be used
    
    var captureCloseIcon: UIImage {
        UIImage(systemName: Images.close)!
    }
    
    var captureTipsIcon: UIImage {
        UIImage(systemName: Images.info)!
    }
}
