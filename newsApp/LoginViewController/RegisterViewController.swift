//
//  RegisterViewController.swift
//  newsApp
//
//  Created by Pankaj Sawale on 04/09/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var pasword: UITextField!
    @IBOutlet weak var registerOut: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func validateFields() -> String? {
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailID.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            pasword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill all the fields."
        } else {
            let validPass  = pasword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if isPasswordValid(validPass) == false {
                
                return "Please make sure your password is at least 8 characters, atleast one special character (%$#*), atleast one number."
            }
            
            return nil
        }
    }
    
    
    @IBAction func registerTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            // remove white spaces and New lines
            let firstName = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailID.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = pasword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Creating User
            Auth.auth().createUser(withEmail: email, password: pass) {
                (result, error) in
                
                if let error = error {
                    self.showError("Error while creating User")
                } else {
                    //User Created Successfully
                    let dataBase = Firestore.firestore()
                    
                    dataBase.collection("users").addDocument(data: ["firstname":firstName,
                                                                    "lastname":lastName, "uid": result!.user.uid]){ (error) in
                        
                        if error != nil {
                            self.showError("Error while saving User's Data")
                        }
                    }
                    // Move Back to login
//                    let vc = storyboard?.instantiateViewController(withIdentifier: "description") as? DescriptionVC
//                    vc?.descriptions = articleData[indexPath.row]
//                    vc?.modalPresentationStyle = .fullScreen
//                    present(vc!, animated: true)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "VC") as? ViewController
                    vc?.modalPresentationStyle = .fullScreen
                    self.present(vc!, animated: true)
                }
            }
        }
    }
    func showError(_ message:String) {
        errorLbl.text = message
        errorLbl.alpha = 1
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
