//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!


// Process the image!
let rgbaImage = RGBAImage(image: image)!;

// Apply some basic filter
for y in 0...rgbaImage.width {
    for x in 0...rgbaImage.height {
        let index = (x * rgbaImage.width) + y;
        
        var red = 0.0
        var green = 0.0
        var blue = 0.0
        
        // TODO: apply the filter here
        
    }
}

class ImageProcessor {
    
    var _image:UIImage;
    
    init (image: UIImage) {
        _image = image;
    }
    
    
}
