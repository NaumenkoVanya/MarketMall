//
//  AddItemViewController.swift
//  MarketMall
//
//  Created by Ваня Науменко on 26.04.23.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView

class AddItemViewController: UIViewController {
    // MARK: IBOutlets
    
    @IBOutlet var tittleTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    // MARK:

    var category: Category!
    var gallery: GalleryController!
    let hud = JGProgressHUD(style: .dark)
    var activityIndicator: NVActivityIndicatorView?
    
    var itemImages: [UIImage?] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBActions
    
    @IBAction func doneBarButtonItemPressend(_ sender: Any) {
        dismissKeayboard()
        if fieldsAreCompleted() {
            saveToFirebase()
            
        } else {
            print("Error all fields are required")
            // TODO: Show error to the user
        }
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        itemImages = []
        showImageGallery()
    }

    @IBAction func backgroundTapped(_ sender: Any) {}
    
    // MARK: Helper functions
    
    private func fieldsAreCompleted() -> Bool {
        return (tittleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "")
    }
    
    private func dismissKeayboard() {
        view.endEditing(false)
    }
    
    private func popTheView() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Save Item
    
    private func saveToFirebase() {
        let item = Item()
        item.id = UUID().uuidString
        item.name = tittleTextField.text!
        item.categoryId = category.id
        item.description = descriptionTextView.text
        item.price = Double(priceTextField.text!)
        
        if itemImages.count > 0 {
            
        } else {
            saveItemToFirestore(item)
            popTheView()
        }
    }
    
    //MARK: Show Gallery
    private func showImageGallery() {
        
        self.gallery = GalleryController()
        self.gallery.delegate = self
        
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 6
        
        self.present(self.gallery, animated: true)
    }
    
}


extension AddItemViewController: GalleryControllerDelegate {
    
    func galleryController(_ controller: Gallery.GalleryController, didSelectImages images: [Gallery.Image]) {
        
        if images.count > 0 {
            Image.resolve(images: images) { (resolvedImages) in
                self.itemImages = resolvedImages
            }
        }
        
        controller.dismiss(animated: true)
    }
    
    func galleryController(_ controller: Gallery.GalleryController, didSelectVideo video: Gallery.Video) {
        controller.dismiss(animated: true)
    }
    
    func galleryController(_ controller: Gallery.GalleryController, requestLightbox images: [Gallery.Image]) {
        controller.dismiss(animated: true)
    }
    
    func galleryControllerDidCancel(_ controller: Gallery.GalleryController) {
        controller.dismiss(animated: true)
    }
    
    
}
