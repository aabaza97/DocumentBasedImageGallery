//
//  Library.swift
//  ImageGallery
//
//  Created by Ahmed Abaza on 22/02/2022.
//

import Foundation

protocol LibraryDelegate {
    func didFinishJob(_ job: Job) -> Void
}

class Library {
    
    // singletone let 
    static let shared = Library()
    
    private init() {}
    
    var libraryDelegate: LibraryDelegate?
    
    var galleries: [Gallery] = []
    
    var recentlyDeleted: [Gallery] = []
    
//    var libraryData: Data? {
//        try? JSONEncoder().encode(self.galleries)
//    }
    
    ///Updates the galllery at the specified index.
    func updateGallery(from gallery: Gallery, at index: Int) -> Void {
        self.galleries[index] = gallery
        libraryDelegate?.didFinishJob(.update)
    }
    
    ///Saved the new gallery.
    func saveGallery(_ gallery: Gallery) -> Void {
        self.galleries.append(gallery)
        libraryDelegate?.didFinishJob(.new)
    }
    
    ///Moves a gallery at a specified index into the recently deleted list.
    func deleteGallery(at index: Int) -> Void {
        let recentlyDeletedGallery = self.galleries.remove(at: index)
        self.recentlyDeleted.append(recentlyDeletedGallery)
        libraryDelegate?.didFinishJob(.delete)
    }
    
    func restoreGallery(at index: Int) -> Void {
        let recentlyDeletedGallery = self.recentlyDeleted.remove(at: index)
        self.galleries.append(recentlyDeletedGallery)
        libraryDelegate?.didFinishJob(.restore)
    }
    
}

enum Job {
    case new
    case update
    case delete
    case restore
}
