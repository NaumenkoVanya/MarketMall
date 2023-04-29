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
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballPulse, color: UIColor(red: 12/255, green: 77/255, blue: 39/255, alpha: 1), padding: nil)
    }
    
    // MARK: IBActions
    
    @IBAction func doneBarButtonItemPressend(_ sender: Any) {
        dismissKeayboard()
        if fieldsAreCompleted() {
            saveToFirebase()
            
        } else {
            print("Error all fields are required")
            // TODO: Show error to the user
            self.hud.textLabel.text = "All fields are required!"
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.0)
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
        
        showLoadingIndicator()
        
        let item = Item()
        item.id = UUID().uuidString
        item.name = tittleTextField.text!
        item.categoryId = category.id
        item.description = descriptionTextView.text
        item.price = Double(priceTextField.text!)
        
        if itemImages.count > 0 {
            
            uploadImages(images: itemImages, itemId: item.id) { (imageLikArray) in
                item.imageLinks = imageLikArray
                
                saveItemToFirestore(item)
                
                self.hideLoadingIndicator()
                self.popTheView()
                
                
            }
            
        } else {
            saveItemToFirestore(item)
            popTheView()
        }
    }
    
    //MARK: Activity Indicator
    
    private func showLoadingIndicator() {
        
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }
    private func hideLoadingIndicator() {
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
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
