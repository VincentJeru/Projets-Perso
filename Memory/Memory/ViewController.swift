//
//  ViewController.swift
//  Memory
//
//  Created by Student on 02/03/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var scoreTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		print( "final score = \(Score.monScore)")
		scoreTextField.text = "\(Score.monScore) pts"
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
