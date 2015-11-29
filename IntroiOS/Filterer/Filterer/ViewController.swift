//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var processor: ImageProcessor?
    
    var filteredImage: UIImage?
    var originalImage: UIImage?

    var filtered: Bool = false
    @IBOutlet weak var originalOverlayLabel: UILabel!
    
    @IBOutlet weak var compareButton: UIButton!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var secondaryView: UIImageView!
    
    @IBOutlet var sliderView: UIView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the secondary view to the view controller and make it match constraints
        secondaryView.addConstraints(imageView.constraints)
        secondaryView.layoutIfNeeded()
        secondaryView.addSubview(originalOverlayLabel)
        
        filtered = false
        compareButton.enabled = filtered
        originalOverlayLabel.hidden = false
        
        // The image has not yet loaded
        originalImage = imageView.image
        secondaryView.image = originalImage
        imageView.image = originalImage
        processor = ImageProcessor(image: originalImage!, filterCollection: ImageFilterCollection(theFilters: []))
    }
    
//    @IBAction func onCompare(sender: UIButton) {
//        if sender.selected {
//            imageView.image = filteredImage
//            sender.selected = false
//        } else {
//            imageView.image = originalImage
//            sender.selected = true
//        }
//    }

    @IBAction func onCompareDown(sender: AnyObject) {
        compareButton.selected = true
        originalOverlayLabel.hidden = false
        secondaryView.setNeedsDisplay()
        
        UIImageView.animateWithDuration(0.25) {
            self.imageView.alpha = 0
            self.secondaryView.alpha = 1
        }
    }
    
    @IBAction func onCompareUp(sender: AnyObject) {
        compareButton.selected = false
        originalOverlayLabel.hidden = true
        
        secondaryView.setNeedsDisplay()
        
        UIImageView.animateWithDuration(0.25) {
            self.imageView.alpha = 1
            self.secondaryView.alpha = 0
        }
    }
    
    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func onEdit(sender: UIButton) {
        if (sender.selected) {
            hideSliderWidget()
            sender.selected = false
        } else {
            hideSecondaryMenu()
            showSliderWidget()
            sender.selected = true
        }
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    // TODO: this is when we pick a new image.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        
        originalImage = imageView.image
        secondaryView.image = imageView.image
        
        processor = ImageProcessor(image: originalImage!, filterCollection: ImageFilterCollection(theFilters: []))
        filtered = false
        compareButton.enabled = filtered
        originalOverlayLabel.hidden = true
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onMedianFilter(sender: UIButton) {
        print("onMedianFilter")
        processor!.apply("Median");
        filteredImage = processor!.produceImage();
        imageView.image = filteredImage
        filtered = true
        compareButton.enabled = filtered
        originalOverlayLabel.hidden = true
    }
    
    @IBAction func onConstrastFilter(sender: UIButton) {
        print("onConstrastFilter")
        processor!.apply("Constrast");
        filteredImage = processor!.produceImage();
        imageView.image = filteredImage
        filtered = true
        compareButton.enabled = filtered
        originalOverlayLabel.hidden = true
    }
    
    @IBAction func onBrightenFilter(sender: UIButton) {
        print("onBrightenFilter")
        processor!.apply("Brighten");
        filteredImage = processor!.produceImage();
        imageView.image = filteredImage
        filtered = true
        compareButton.enabled = filtered
        originalOverlayLabel.hidden = true
    }

    @IBAction func onSharpenFilter(sender: UIButton) {
        print("onSharpenFilter")
        processor!.apply("Sharpen");
        filteredImage = processor!.produceImage();
        imageView.image = filteredImage
        filtered = true
        compareButton.enabled = filtered
        originalOverlayLabel.hidden = true
    }
    
    @IBAction func onBlurFilter(sender: UIButton) {
        print("onBlurFilter")
        processor!.apply("Blur");
        filteredImage = processor!.produceImage();
        imageView.image = filteredImage
        filtered = true
        compareButton.enabled = filtered
        originalOverlayLabel.hidden = true
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            hideSliderWidget()
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    func showSliderWidget() {
        view.addSubview(sliderView)
        
        let bottomConstraint = sliderView.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = sliderView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = sliderView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = sliderView.heightAnchor.constraintEqualToConstant(40)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.sliderView.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.sliderView.alpha = 1.0
        }
    }
    
    func hideSliderWidget() {
        UIView.animateWithDuration(0.4, animations: {
            self.sliderView.alpha = 0
            }) { completed in
                if completed == true {
                    self.sliderView.removeFromSuperview()
                }
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }

}

