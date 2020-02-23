//
//  Classifier.swift
//  Admeme
//
//  Created by Jhovan Gallardo on 20/02/20.
//  Copyright © 2020 UNAM. All rights reserved.
//

import Foundation
import Vision


class Classifier {
    
    // Classifies all files in Documents into, dsjointed groups
    // based on their feature print "distance"
    // ALWAYS returns non empty arrays
    static func generateGroups() -> [[String]] {
        let urls =  ImageManager.getAllFileUrls()
        var featurePrints: [VNFeaturePrintObservation?] = []
        var groups: [[String]] = []
        
        for url in urls {
            featurePrints.append(self.featureprintObservationForImage(atURL: url))
        }
        
        // keeps track of the images that are already in a group
        var inGroup = [Bool](repeatElement(false,
                                           count: featurePrints.count))
        for i in stride(from: 0, through: featurePrints.count - 1, by: 1) {
            if !inGroup[i] {
                if let featurePrint = featurePrints[i] {
                    var group: [String] = [urls[i].path]
                    inGroup[i] = true
                    for j in stride(from: i + 1, through: featurePrints.count - 1, by: 1) {
                        if !inGroup[j] {
                            if let comparingPrint = featurePrints[j] {
                                do {
                                    // If distance is small, then both images will be in the same group
                                    var distance = Float(0)
                                    try featurePrint.computeDistance(&distance, to: comparingPrint)
                                    if distance <= Constants.MAX_DISTANCE {
                                        group.append(urls[j].path)
                                        inGroup[j] = true
                                    }
                                }
                                catch {
                                    
                                }
                            }
                        }
                    }
                    groups.append(group)
                }
            }
        }
        return groups
    }
    
    // Generates a featureprint for a given image URL
    static private func featureprintObservationForImage(atURL url: URL) -> VNFeaturePrintObservation? {
        let requestHandler = VNImageRequestHandler(url: url, options: [:])
        let request = VNGenerateImageFeaturePrintRequest()
        do {
            try requestHandler.perform([request])
            return request.results?.first as? VNFeaturePrintObservation
        } catch {
            print("Vision error: \(error)")
            return nil
        }
    }
}
