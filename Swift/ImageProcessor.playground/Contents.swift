//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

class ImageFilterCollection {
    var filters: [ImageFilter];
    
    init(theFilters:[ImageFilter]) {
        filters = theFilters;
        populate();
    }
    
    private func populate() {
        let blurFilter = ImageFilter(filterArray: [[0.0, 0.2, 0.0], [0.2, 0.2, 0.2], [0.0, 0.2, 0.0]],
            filterBias: {(avg:Int, filtered:Double, actual:UInt8) -> Double in 0.0},
            filterFactor: {(avg:Int, filtered:Double, actual:UInt8) -> Double in 1.0},
            filterName: "Blur");
        filters.append(blurFilter);
        
        let sharpenFilter = ImageFilter(filterArray: [[-1.0, -1.0, -1.0], [-1.0, -9.0, -1.0], [-1.0, -1.0, -1.0]],
            filterBias: {(avg:Int, filtered:Double, actual:UInt8) -> Double in 0.0},
            filterFactor: {(avg:Int, filtered:Double, actual:UInt8) -> Double in 1.0},
            filterName: "Sharpen");
        filters.append(sharpenFilter);
        
        let brightnessFilter = ImageFilter(filterArray: [[1.0]],
            filterBias: { (avg:Int, filtered:Double, actual:UInt8) -> Double in 75.0 },
            filterFactor: {(avg:Int, filtered:Double, actual:UInt8) -> Double in 1.0},
            filterName: "Brighten");
        filters.append(brightnessFilter);
        
        let contrastFilter = ImageFilter(filterArray: [[1.0]],
            filterBias: {(avg:Int, filtered:Double, actual:UInt8) -> Double in 50},
            filterFactor: {(avg:Int, filtered:Double, actual:UInt8) -> Double in 2.2},
            filterName: "Contrast");
        filters.append(contrastFilter);
        
        let medianFilter = ImageFilter(filterArray: [[1.0, 1.0, 1.0], [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]],
            filterBias: {(avg:Int, filtered:Double, actual:UInt8) -> Double in 0.0},
            filterFactor: {(avg:Int, filtered:Double, actual:UInt8) -> Double in (1.0 / 9.0)},
            filterName: "Median");
        filters.append(medianFilter);
    }
    
    func lookup(name: String) -> ImageFilter? {
        let target = name.lowercaseString
        for filter in filters {
            if filter.name.lowercaseString.containsString(target) {
                return filter;
            }
        }
        return nil;
    }
}

class ImageFilter {
    var width: Int;
    var height: Int;
    var name: String;
    var _array: [[Double]];
    var bias: (Int, Double, UInt8) -> Double;
    var factor: (Int, Double, UInt8) -> Double;
    
    init(filterArray: [[Double]], filterBias: (Int, Double, UInt8) -> Double, filterFactor: (Int, Double, UInt8) -> Double, filterName: String) {
        _array = filterArray;
        width = _array.count;
        height = _array[0].count;
        bias = filterBias;
        factor = filterFactor;
        name = filterName;
    }
    
    func weight(x: Int, y: Int) -> Double {
        return _array[x][y];
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
    var collection:ImageFilterCollection;
    
    init(image: UIImage, filterCollection: ImageFilterCollection) {
        _image = image;
        _rgbaImage = RGBAImage(image: image)!;
        averageRed = 0;
        averageGreen = 0;
        averageBlue = 0;
        collection = filterCollection;
        
        // Preprocess the image
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
    
    func apply(names: String...) {
        for name in names {
            if let filter = collection.lookup(name) {
                apply_filter(filter);
            } else {
                print("Unable to find a filter with the name " + name);
            }
        }
    }
    
    func apply_filters(filters: [ImageFilter]) {
        for filter in filters {
            apply_filter(filter);
        }
    }
    
    func apply_filter(filter: ImageFilter) {
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
                
                // Compute the new pixel RGB values based on a function of the filter factor
                // and bias
                pixel.red = UInt8(max(min(255,
                    filter.factor(averageRed, red, pixel.red) * red +
                        filter.bias(averageRed, red, pixel.red)), 0));
                
                pixel.green = UInt8(max(min(255,
                    filter.factor(averageGreen, green, pixel.green) * green +
                        filter.bias(averageGreen, green, pixel.green)), 0));
                
                pixel.blue = UInt8(max(min(255,
                    filter.factor(averageBlue, blue, pixel.blue) * blue +
                        filter.bias(averageBlue, blue, pixel.blue)), 0));
                
                // Store the updated result
                _rgbaImage.pixels[index] = pixel;
            }
        }

    }
    
    func produceImage() -> UIImage {
        return _rgbaImage.toUIImage()!
    }
}

let processor = ImageProcessor(image: image, filterCollection: ImageFilterCollection(theFilters: []));

processor.apply("Brighten", "Blur");

let imageCopy = UIImage(named: "sample")!;

let newImage = processor.produceImage();


{