//
//  DocumentBrowserViewController.swift
//  DocumentBasedImageGallery
//
//  Created by Ahmed Abaza on 01/03/2022.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    //MARK: - Properties
    var tempURL: URL?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.allowsDocumentCreation = false
        self.allowsPickingMultipleItems = false
        
        // Update the style of the UIDocumentBrowserViewController
        self.browserUserInterfaceStyle = BrowserUserInterfaceStyle.init(rawValue: UInt(traitCollection.userInterfaceStyle.rawValue))!
        self.view.tintColor = .label
        
        
        //preparing the tempURL
        self.tempURL = try? self.getDefaultDocumentPath()
        if let tempURL = tempURL {
            self.allowsDocumentCreation = FileManager.default.createFile(atPath: tempURL.path, contents: Data())
        }
        
        
        // Specify the allowed content types of your application via the Info.plist.
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Functions
    private func getDefaultDocumentPath() throws -> URL? {
        try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("UntitledGallery.json")
    }
    
    
    // MARK: - UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        importHandler(tempURL, .copy)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
        
        let alert = UIAlertController(title: "Failed to Open", message: "Couldn't parse file.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true)
        }))
         
        self.present(alert, animated: true)
    }
    
    
    // MARK: - Document Presentation
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let navController = storyBoard.instantiateViewController(withIdentifier: "galleryNavigationController")
        navController.modalPresentationStyle = .fullScreen
        
        if let homeVC = navController.contents as? HomeViewController {
            homeVC.galleryDocument = GalleryDocument(fileURL: documentURL)
        }
        
        present(navController, animated: true, completion: nil)
    }
}

