//
//  ForgotPassword.swift
//  newStory
//
//  Created by Karandeep Singh on 2021-01-15.
//

import UIKit
import Firebase

class ForgotPassword: UIViewController {
    
    @IBOutlet weak var headerForgotPassView: UIView!
    @IBOutlet weak var controlForgotPassView: UIView!
    @IBOutlet weak var btnForgotPass: UIButton!
    @IBOutlet weak var etForgotPass: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    

    @IBAction func btnClick(_ sender: Any) {
                Auth.auth().sendPasswordReset(withEmail: self.etForgotPass.text!) { error in
        
                                            if let error = error {
                                                self.showAlert(title: error.localizedDescription, message: "")
                                            //self.errorText = error.localizedDescription
                                            return
                                            }
                    self.showAlert(title: "Forgot Password link sent", message: "Please check your Email and click the forgot password link for reset the password")
                                           //self.showPasswordAlert.toggle()
        
                                            }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
    }
    
    func initUI() {
        let appColor = UIColor(named: "app")
        
        headerForgotPassView.layer.cornerRadius = 32
        controlForgotPassView.layer.cornerRadius = 32
        btnForgotPass.layer.cornerRadius = 7
        etForgotPass.attributedPlaceholder = NSAttributedString(string: "Enter Your Email",attributes: [NSAttributedString.Key.foregroundColor: appColor])
        
    }
    
    //dismiss keypad
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
