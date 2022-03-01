//
//  Document.swift
//  DocumentBasedImageGallery
//
//  Created by Ahmed Abaza on 01/03/2022.
//

import UIKit

class GalleryDocument: UIDocument {
    
    var gallery: Gallery?
    
    override func contents(forType typeName: String) throws -> Any {
        self.gallery?.jsonData ?? Data()
    }
    
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let documentData = contents as? Data {
            self.gallery = Gallery(from: documentData)
        }
    }
}

