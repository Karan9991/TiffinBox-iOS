//
//  SignUp.swift
//  newStory
//
//  Created by Karandeep Singh on 2020-12-28.
//

//import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUp: UIViewController, UITableViewDelegate, UITableViewDataSource, Validate {
    
    @IBOutlet weak var headerSignupView: UIView!
    @IBOutlet weak var controlSignupView: UIView!
    @IBOutlet weak var etSignupEmail: UITextField!
    @IBOutlet weak var etSignUpName: UITextField!
    @IBOutlet weak var etSignUpPhone: UITextField!
    @IBOutlet weak var etSignUpPass: UITextField!
    @IBOutlet weak var etSignUpAddr: UITextField!
    @IBOutlet weak var tvSignUp: UILabel!
    @IBOutlet weak var tblDropDown: UITableView!
    @IBOutlet weak var tblDropDownHC: NSLayoutConstraint!
    @IBOutlet weak var btnNumberOfRooms: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var isTableVisible = false
    var users: User!
    var ref: DatabaseReference!
    var isValid = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        users = User()
        
        ref = Database.database().reference()
        ref.child("online_drivers").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let username = value?["username"] as? String ?? ""
            print("Fuck Yes",value ?? "nil")
          //let user = User(username: username)

          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        
//         users = User(name: "Karan", mobile: "4168165877", email: "karan7449@gmail.com", password: "Raj123$", address: "Canada", userType: "Seller")
        users.userName = "Raj"
       // users.address = "xxx"
       // users.userType = "Cus"
    }
    
    
    @IBAction func btnSignUp(_ sender: Any) {
        print(btnNumberOfRooms.currentTitle)
        if validations() {
            self.signUp(email: etSignupEmail.text!, password: etSignUpPass.text!)
        }
    }
    
    @objc
       func tvSignUp_Click(sender:UITapGestureRecognizer) {
        navigateToAhead()
       }
    
    func navigateToAhead () {
        self.dismiss(animated: true, completion: nil)
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! ViewController
        self.navigationController?.pushViewController(myVC, animated: true)
        self.navigationItem.hidesBackButton = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UITableView delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "numberofrooms")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "numberofrooms")
            if indexPath.row == 0{
                cell?.textLabel?.text = "Customer"

            } else if indexPath.row == 1 {
            cell?.textLabel?.text = "Seller"
            }

        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            btnNumberOfRooms.setTitle("  User Type: Customer", for: .normal)

        } else if indexPath.row == 1 {
            btnNumberOfRooms.setTitle("  User Type: Seller", for: .normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.tblDropDownHC.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func selectNumberOfRooms(_ sender : AnyObject) {
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false {
                self.isTableVisible = true
             self.tblDropDownHC.constant = 44.0 * 2.0
            } else {
                self.tblDropDownHC.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    
    //lock orientation
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    func initUI()  {
        let appColor = UIColor(named: "app")

       headerSignupView.layer.cornerRadius = 32
       controlSignupView.layer.cornerRadius = 32
        etSignupEmail.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedString.Key.foregroundColor: appColor])
        etSignUpName.attributedPlaceholder = NSAttributedString(string: "Name",attributes: [NSAttributedString.Key.foregroundColor: appColor])
        etSignUpPhone.attributedPlaceholder = NSAttributedString(string: "Phone",attributes: [NSAttributedString.Key.foregroundColor: appColor])
        etSignUpAddr.attributedPlaceholder = NSAttributedString(string: "Address",attributes: [NSAttributedString.Key.foregroundColor: appColor])
        etSignUpPass.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: appColor])
        btnSignUp.layer.cornerRadius = 25
        btnNumberOfRooms.contentHorizontalAlignment = .left

    
        //label click
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUp.tvSignUp_Click(sender:)))
              tvSignUp.isUserInteractionEnabled = true
              tvSignUp.addGestureRecognizer(tap)
        
        //tableview
        tblDropDown.delegate = self
        tblDropDown.dataSource = self
        tblDropDownHC.constant = 0
        
        btnNumberOfRooms.layer.borderWidth = 1.0;
        btnNumberOfRooms.layer.cornerRadius = 5.0;
        btnNumberOfRooms.layer.borderColor = CGColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1);
        
    }
    
    //dismiss keypad
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func signUp(email: String, password: String) {
          
              Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
               
               guard let user = authResult?.user, error == nil else {
                
                   let errorText: String  = error?.localizedDescription ?? "unknown error"
                  // self.errorText = errorText
                print(errorText)
                self.showAlert(title: errorText, message: "")
                   
                 return
               }
               
               Auth.auth().currentUser?.sendEmailVerification { (error) in
                   if let error = error {
                    //   self.errorText = error.localizedDescription
                    print(error.localizedDescription)
                    self.showAlert(title: error.localizedDescription, message: "")

                     return
                   }
                 //  self.showAlert.toggle()
                   
                  // self.shouldAnimate = fals
               }
                self.showAlert(title: "Verification email sent", message: "Check your Email ID for click the link to verify")
               print("\(user.email!) created")
           }
       }
       
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
    }
    
    func validations() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
     
        if (etSignUpName.text?.isEmpty ?? false) {
            isValid = false
            showAlert(title: "Name is required", message: "")
        }
        else  if (etSignUpPhone.text?.isEmpty ?? false) {
             isValid = false
             showAlert(title: "Phone is required", message: "")
        }
        else if (etSignupEmail.text?.isEmpty ?? false) {
            isValid = false
            showAlert(title: "Email is required", message: "")
        }
       else if !emailPred.evaluate(with: etSignupEmail.text) {
            isValid = false
            showAlert(title: "Please enter valid Email", message: "")
        }
       else  if (etSignUpPass.text?.isEmpty ?? false) {
           isValid = false
           showAlert(title: "Password is required", message: "")
       }
       else  if (etSignUpAddr.text?.isEmpty ?? false) {
             isValid = false
             showAlert(title: "Address is required", message: "")
       }
       else  if (btnNumberOfRooms.currentTitle == "  Select User Type") {
             isValid = false
             showAlert(title: "User Type is required", message: "")
       }
        else {
            isValid = true
        }
        
        return isValid
    }
       
   }

