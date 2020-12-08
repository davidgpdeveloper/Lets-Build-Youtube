//
//  ViewControllerSampleOne.swift
//  Youtube
//
//  Created by DavidGP on 3/12/20.
//  Copyright © 2020 Studiogenesis Home. All rights reserved.
//

import UIKit


//
class ViewControllerSampleOne: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        initialActions()
        secondAction()
    }

    // 1
    func initialActions() {
        
        print("initialActions")
        
    }
    
    // 2
    func secondAction() {
        print("secondAction")
    }
    
    // 3
    func extraAction() {
        print("Added from web")
    }
    
}

extension ViewControllerSampleOne {
    
    func functionTestingExtention() {

        print("Deleted prints")
    }
}
