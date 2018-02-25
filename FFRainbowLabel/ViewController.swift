//
//  ViewController.swift
//  FFRainbowLabel
//
//  Created by JonyFang on 2018/2/24.
//  Copyright © 2018年 JonyFang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rainbowLabel: FFRainbowLabel!
    
    let gradientColors = [UIColor(red:0.79, green:0.30, blue:0.64, alpha:1.00),
                          UIColor(red:0.08, green:0.33, blue:0.82, alpha:1.00)]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupGradientPoints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private Methods
    fileprivate func setupViews() {
        rainbowLabel.fillColor = .red
        rainbowLabel.gradientColors = gradientColors
        rainbowLabel.fillOption = .Text
    }
    
    fileprivate func setupGradientPoints() {
        rainbowLabel.startPoint = CGPoint.zero
        rainbowLabel.endPoint = CGPoint(x: rainbowLabel.frame.width, y: rainbowLabel.frame.height)
    }
}

