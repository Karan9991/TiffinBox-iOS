//
//  SignUp.swift
//  newStory
//
//  Created by Karandeep Singh on 2020-12-28.
//

//import Foundation
import UIKit

class SignUp: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    @IBAction func btnSignUp(_ sender: Any) {
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

}
