//
//  ViewController.swift
//  CS_Common_UI
//
//  Created by ChristianSlanzi on 10/20/2020.
//  Copyright (c) 2020 ChristianSlanzi. All rights reserved.
//

import UIKit
import CS_Common_UI

public let blueTheme = Theme(rawValue: "Dusk")

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateColors(for: blueTheme)
        
        //this set the blueTheme theme.
        // In assets you can define the palette for the theme
        // Dusk-contentBackground is the default bg color

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

