//
//  User.swift
//  newStory
//
//  Created by Karandeep Singh on 2021-01-14.
//

import Foundation

class User{
    
    var name: String?
    var mobile: String?
    var email: String?
    var password: String?
    var address: String?
    var userType: String?
    
    init() {
        
    }
    
    init(name: String?, mobile: String?, email: String?, password: String?, address: String?, userType: String?) {
        self.name = name
        self.mobile = mobile
        self.email = email
        self.password = password
        self.address = address
        self.userType = userType
    }
    
    var userName: String? {
        set { name = newValue }
        get { return name }
    }
    
    var userMobile: String? {
        set { mobile = newValue }
        get { return mobile }
    }
    
    var userEmail: String? {
        set { email = newValue }
        get { return email }
    }
    
    var userPassword: String? {
        set { password = newValue }
        get { return password }
    }
    
    var userAddress: String? {
        set { address = newValue }
        get { return address }
    }
    
    var userUserType: String? {
        set { userType = newValue }
        get { return userType }
    }
}
