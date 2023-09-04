//
//  ViewController.swift
//  newsApp
//
//  Created by Pankaj Sawale on 04/09/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var pasword: UITextField!
    @IBOutlet weak var loginOut: UIButton!
    @IBOutlet weak var registerOut: UIButton!
    @IBOutlet weak var gLoginOut: UIButton!
    @IBOutlet weak var aLoginOut: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIConfig()
    }
    func UIConfig(){
        loginOut.layer.cornerRadius = 10
        gLoginOut.layer.cornerRadius = 10
        aLoginOut.layer.cornerRadius = 10
    }

    @IBAction func loginTapped(_ sender: Any) {
        //
        let email = emailID.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = pasword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: pass) {
            (result, error) in
            // Error while SiginingIn
            if error != nil {
                self.errorLbl.text = error!.localizedDescription
                self.errorLbl.alpha = 1
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HeadsLines") as? HeadsLinesVC
                vc?.modalPresentationStyle = .fullScreen
                self.present(vc!, animated: true)
            }
        }
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Register") as? RegisterViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
        
    }
    
    @IBAction func gLoginTapped(_ sender: Any) {
        
    }
    
    @IBAction func aLoginTapped(_ sender: Any) {
        
    }
    
    
}

