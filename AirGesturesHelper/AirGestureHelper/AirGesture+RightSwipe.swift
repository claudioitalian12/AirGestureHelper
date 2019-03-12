//
//  AirGesture+RightSwipe.swift
//  AirGesturesHelper
//
//  Created by gesture machines on 08/03/2019.
//  Copyright © 2019 gesture machines. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

extension AirGesturesHelper{
    
    func rightSwipeGesture(completion: (Bool) -> ()){
        
       traslationDuringAcrion.append(self.highlightView.center.x)
        
        if(isSorted(arr: traslationDuringAcrion) == true && rootVC.view.center.x + 150 < self.highlightView.center.x){
       traslationDuringAcrion.removeAll()
       completion(true)
        }
        else {        completion(false)}
  
    }
    
    func leftSwipeGesture(completion: (Bool) -> ()){
    if(isSorted2(arr: traslationDuringAcrion) == true && rootVC.view.center.x - 150 > self.highlightView.center.x){

    completion(true)
    }
    else {      completion(false)}
        
    }
    
    
    func isSorted(arr: [CGFloat]) -> Bool{

    if(arr.isEmpty) {
    //Depends on what you have to return for null condition
    return false;
    }
    //If we find any element which is greater then its next element we return false.
        
        for var i in 0..<arr.count-1 {
            print("efwefewf")
            if(arr[i] > arr[i+1]) {
                traslationDuringAcrion.removeFirst(i+1)
                return false;
            }
            i = i + 1
            
        }
    
    //If array is finished processing then return true as all elements passed the test.
    return true;
    }

    func isSorted2(arr: [CGFloat]) -> Bool{
        
        if(arr.isEmpty) {
            //Depends on what you have to return for null condition
            return false;
        }
        //If we find any element which is greater then its next element we return false.
        
        for var i in 0..<arr.count-1 {
            print("efwefewf")
            if(arr[i] < arr[i+1]) {
                traslationDuringAcrion.removeFirst(i+1)
                return false;
            }
            i = i + 1
            
        }
        
        //If array is finished processing then return true as all elements passed the test.
        return true;
    }
    
}
