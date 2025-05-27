//
//  CustomFonts.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-16.
//

import Sensibill

/// Demonstrates the implementation of `BrandingFontsProvider`
class CustomFonts: BrandingFontsProvider {
    
    /// Branding fonts could be defined elsewhere, and in any way (e.g. constants, resources)
    private enum Faces {
        static let typewriter = "AmericanTypewriter"
        static let heavy = "AvenirNext-Heavy"
        static let elegant = "Baskerville-Italic"
        static let handwriting = "BradleyHandITCTT-Bold"
        static let chalkboard = "Chalkduster"
        static let bold = "Charter-Black"
        static let wide = "Copperplate"
        static let small = "SnellRoundhand"
        
    }
    
    // MARK: - Define Branding Fonts
    
    var largeTitle: Sensibill.Branding.FontDefinition {
        Branding.FontDefinition(name: Faces.heavy, size: 20, style: .largeTitle)
    }
    
    var title2: Sensibill.Branding.FontDefinition {
        Branding.FontDefinition(name: Faces.wide, size: 16, style: .largeTitle)
    }
    
    var title3: Sensibill.Branding.FontDefinition {
        Branding.FontDefinition(name: Faces.bold, size: 14, style: .largeTitle)
    }
    
    var body: Sensibill.Branding.FontDefinition {
        Branding.FontDefinition(name: Faces.typewriter, size: 17, style: .largeTitle)
    }
    
    var subheadline: Sensibill.Branding.FontDefinition {
        Branding.FontDefinition(name: Faces.chalkboard, size: 13, style: .largeTitle)
    }
    
    var footnote: Sensibill.Branding.FontDefinition {
        Branding.FontDefinition(name: Faces.handwriting, size: 15, style: .largeTitle)
    }
    
    var caption: Sensibill.Branding.FontDefinition {
        Branding.FontDefinition(name: Faces.elegant, size: 12, style: .largeTitle)
    }
    
    var forWebUI: (family: String, url: String)? {
        (
            family: "Lobster, Times, serif",
            url: "https://fonts.googleapis.com/css2?family=Lobster&display=swap"
        )
    }
}
