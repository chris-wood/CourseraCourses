//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

class ImageFilter {
    var width: Int;
    var height: Int;
    var name: String;
    var _array: [[Double]];
    var _bias: Double;
    
    init(filterArray: [[Double]], filterBias: Double, filterName: String) {
        _array = filterArray;
        width = _array.count;
        height = _array[0].count;
        _bias = filterBias;
        name = filterName;
    }
    
    func weight(x: Int, y: Int) -> Double {
        return _array[x][y];
    }
    
    func bias() -> Double {
        return _bias;
    }
    
    func getName() -> String {
        return name;
    }
}

class ImageProcessor {
    
    private var _image:UIImage;
    private var _rgbaImage:RGBAImage;
    var averageRed:Int;
    var averageGreen:Int;
    var averageBlue:Int;
    
    init(image: UIImage) {
        _image = image;
        _rgbaImage = RGBAImage(image: image)!;
        averageRed = 0;
        averageGreen = 0;
        averageBlue = 0;
        preprocess();
    }
    
    private func preprocess() {
        let pixelCount = Double(_rgbaImage.width * _rgbaImage.height);
        
        var red = 0.0
        var green = 0.0
        var blue = 0.0
        
        for yy in 0..<_rgbaImage.height {
            for xx in 0..<_rgbaImage.width {
                let inner = (yy * _rgbaImage.width) + xx;
                red += Double(_rgbaImage.pixels[inner].red);
                green += Double(_rgbaImage.pixels[inner].green);
                blue += Double(_rgbaImage.pixels[inner].blue);
            }
        }
        
        averageRed = Int(red / pixelCount);
        averageGreen = Int(green / pixelCount);
        averageBlue = Int(blue / pixelCount);
        
        print(averageRed)
        print(averageGreen)
        print(averageBlue)
    }
    
    func apply_filter(filter: ImageFilter, factor: Double) {
        for row in 0..<_rgbaImage.height {
            for col in 0..<_rgbaImage.width {
                
                var red = 0.0;
                var green = 0.0;
                var blue = 0.0;
                
                let index = (row * _rgbaImage.width) + col
                var pixel = _rgbaImage.pixels[index];

                for x in 0..<filter.width {
                    for y in 0..<filter.height {
                        let imageX = (col - (filter.width / 2) + x + _rgbaImage.width) % _rgbaImage.width;
                        let imageY = (row - (filter.height / 2) + y + _rgbaImage.height) % _rgbaImage.height;
                        let index = (imageY * _rgbaImage.width) + imageX;
                        
                        red += Double(_rgbaImage.pixels[index].red) * filter.weight(x, y: y);
                        green += Double(_rgbaImage.pixels[index].green) * filter.weight(x, y: y);
                        blue += Double(_rgbaImage.pixels[index].blue) * filter.weight(x, y: y);
                    }
                }
                
                pixel.red = UInt8(max(min(255, factor * red + filter.bias()), 0));
                pixel.green = UInt8(max(min(255, factor * green + filter.bias()), 0));
                pixel.blue = UInt8(max(min(255, factor * blue + filter.bias()), 0));
                
                // Store the updated result
                _rgbaImage.pixels[index] = pixel;
            }
        }

    }
    
    func produceImage() -> UIImage {
        return _rgbaImage.toUIImage()!
    }
}

let blurFilter = ImageFilter(filterArray: [[0.0, 0.2, 0.0], [0.2, 0.2, 0.2], [0.0, 0.2, 0.0]], filterBias: 0.0, filterName: "Blur");
let sharpenFilter = ImageFilter(filterArray: [[-1.0, -1.0, -1.0], [-1.0, -9.0, -1.0], [-1.0, -1.0, -1.0]], filterBias: 1.0, filterName: "Sharpen");
let brightnessFilter = ImageFilter(filterArray: <#T##[[Double]]#>, filterBias: 1.0, filterName: "Brighten");
let contrastFilter = ImageFilter(filterArray: <#T##[[Double]]#>, filterBias: 1.0, filterName: "Contrast");
let medianFilter = ImageFilter(filterArray: <#T##[[Double]]#>, filterBias: 1.0, filterName: "Median");


let processor = ImageProcessor(image: image);
processor.apply_filter(blurFilter, factor: 1.0);
let newImage = processor.produceImage();

/*
