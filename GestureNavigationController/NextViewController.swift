//
//  NextViewController.swift
//  GestureNavigationController
//
//  Created by Stephen Wingchi Wong on 10/8/17.
//  Copyright © 2017 S. Wingchi Wong. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var displayTitle: String? = nil
    
    init(title: String) {
        super.init(nibName: String(describing: NextViewController.self), bundle: nil)
        displayTitle = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = displayTitle
    }

}
