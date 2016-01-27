
import UIKit
class resetPasswordViewController: UIViewController,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITextFieldDelegate
{
    let button = UIButton()
    let resetPasswordButton = UIButton()
    let printButton = UIButton()
    let userListButton = UIButton()
    let exampleTitle = UILabel()
    let newPasswordTitle = UILabel()
    let confirmPasswordTitle = UILabel()
    let newPasswordField = UITextField()
    let confirmPasswordField = UITextField()
    let changePasswordButton = UIButton()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(exampleTitle)
        exampleTitle.backgroundColor = UIColor.lightGrayColor()
        exampleTitle.sizeToHeight(30)
        exampleTitle.sizeToWidth(600)
        exampleTitle.pinToTopEdgeOfSuperview(20)
        exampleTitle.centerHorizontallyInSuperview()
        exampleTitle.font = UIFont(name: "AvenirNext-DemiBold", size: 30)
        exampleTitle.textAlignment = NSTextAlignment.Center
        exampleTitle.text = "Example App"
        exampleTitle.textColor = UIColor.whiteColor()

        
        self.view.addSubview(newPasswordTitle)
        newPasswordTitle.sizeToHeight(40)
        newPasswordTitle.sizeToWidth(150)
        newPasswordTitle.centerVerticallyInSuperview()
        newPasswordTitle.pinToLeftEdgeOfSuperview(30)
        newPasswordTitle.text = "New Password: "
        
        self.view.addSubview(newPasswordField)
        newPasswordField.delegate = self
        newPasswordField.sizeToHeight(40)
        newPasswordField.sizeToWidth(200)
        newPasswordField.positionToTheRightOfItem(newPasswordTitle, offset: 10)
        newPasswordField.centerVerticallyInSuperview()
        newPasswordField.layer.borderWidth = 1
        newPasswordField.layer.borderColor = UIColor.blackColor().CGColor
        
        self.view.addSubview(confirmPasswordTitle)
        confirmPasswordTitle.sizeToHeight(40)
        confirmPasswordTitle.sizeToWidth(200)
        confirmPasswordTitle.positionBelowItem(newPasswordTitle, offset: 20)
        confirmPasswordTitle.pinToLeftEdgeOfSuperview(30)
        confirmPasswordTitle.text = "Confirm Password: "
        
        self.view.addSubview(confirmPasswordField)
        confirmPasswordField.delegate = self
        confirmPasswordField.sizeToHeight(40)
        confirmPasswordField.sizeToWidth(200)
        confirmPasswordField.positionBelowItem(newPasswordField, offset: 20)
        confirmPasswordField.pinLeftEdgeToLeftEdgeOfItem(newPasswordField)
        confirmPasswordField.layer.borderWidth = 1
        confirmPasswordField.layer.borderColor = UIColor.blackColor().CGColor
        
        self.view.addSubview(changePasswordButton)
        changePasswordButton.backgroundColor = UIColor.purpleColor()
        changePasswordButton.sizeToHeight(40)
        changePasswordButton.sizeToWidth(200)
        changePasswordButton.centerHorizontallyInSuperview()
        changePasswordButton.positionBelowItem(confirmPasswordField, offset: 30)
        changePasswordButton.setTitle("Change Password", forState: UIControlState.Normal)
        changePasswordButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        changePasswordButton.addTarget(self, action: "passwordCheck", forControlEvents: .TouchUpInside)
        
        
        self.view.addSubview(button)
        button.backgroundColor = UIColor.darkGrayColor()
        button.sizeToHeight(40)
        button.sizeToWidth(100)
        button.pinToBottomEdgeOfSuperview()
        button.setTitle("Logout", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        button.addTarget(self, action: "logoutAction", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(resetPasswordButton)
        resetPasswordButton.backgroundColor = UIColor.darkGrayColor()
        resetPasswordButton.pinToBottomEdgeOfSuperview()
        resetPasswordButton.sizeToHeight(40)
        resetPasswordButton.sizeToWidth(100)
        resetPasswordButton.positionToTheRightOfItem(button, offset: 5)
        resetPasswordButton.setTitle("Reset Pswd", forState: UIControlState.Normal)
        resetPasswordButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        resetPasswordButton.addTarget(self, action: "resetAction", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(printButton)
        printButton.backgroundColor = UIColor.darkGrayColor()
        printButton.sizeToHeight(40)
        printButton.sizeToWidth(100)
        printButton.pinToRightEdgeOfSuperview()
        printButton.pinToBottomEdgeOfSuperview()
        printButton.setTitle("Print Text", forState: UIControlState.Normal)
        printButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        printButton.addTarget(self, action: "printAction", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(userListButton)
        userListButton.backgroundColor = UIColor.darkGrayColor()
        userListButton.sizeToHeight(40)
        userListButton.sizeToWidth(100)
        userListButton.positionToTheLeftOfItem(printButton, offset: 5)
        userListButton.pinToBottomEdgeOfSuperview()
        userListButton.setTitle("User List", forState: UIControlState.Normal)
        userListButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        userListButton.addTarget(self, action: "userListAction", forControlEvents: .TouchUpInside)
        
    }//viewDidLoad
    func loginSetup()
    {
        if (PFUser.currentUser() == nil)
        {
            let loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            
            let signupViewController = PFSignUpViewController()
            signupViewController.delegate = self
            
            loginViewController.signUpController = signupViewController
            loginViewController.fields = ([PFLogInFields.LogInButton, PFLogInFields.SignUpButton, PFLogInFields.UsernameAndPassword,  PFLogInFields.PasswordForgotten , PFLogInFields.DismissButton])
            
            
            //            let signupTitle = UILabel()
            //            signupTitle.text = "Barter Signup"
            //loginLogo
            let loginLogoImageView = UIImageView()
            loginLogoImageView.image = UIImage(named: "swap")
            loginLogoImageView.contentMode = UIViewContentMode.ScaleAspectFit
            //signupLogo
            let signupLogoImageView = UIImageView()
            signupLogoImageView.image = UIImage(named: "swap")
            signupLogoImageView.contentMode = UIViewContentMode.ScaleAspectFit
            
            loginViewController.view.backgroundColor = UIColor.whiteColor()
            signupViewController.view.backgroundColor = UIColor.whiteColor()
            loginViewController.logInView?.logo = loginLogoImageView
            signupViewController.signUpView?.logo = signupLogoImageView
            
            
            self.presentViewController(loginViewController, animated: true, completion: nil)
        }//if
    }//func
    
    //Checks if username and password are empty
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool
    {
        if (!username.isEmpty || !password.isEmpty)
        {
            return true
        }//if
        else
        {
            return false
        }//else
    }//func
    
    //Closes login view after user logs in
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }//func
    
    //Checks for login error
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?)
    {
        print("Failed to login....")
    }//func
    
    //MARK: Parse SignUp
    
    //Closes signup view after user signs in
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }//func
    
    //Checks for signup error
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?)
    {
        print("Failed to signup")
    }//func
    
    //Checks if user cancelled signup
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController)
    {
        print("User dismissed signup")
    }//func
    
    //Logs out user
    func logoutAction()
    {
        print("logging out")
        PFUser.logOut()
        self.loginSetup()
    }//func
    
    func printAction()
    {
        print("clicked")
        let PVC = printViewController()
        self.presentViewController(PVC, animated: false, completion: nil)
    }//func
    
    func userListAction()
    {
        print("clicked")
        let PVC = LoginViewController()
        self.presentViewController(PVC, animated: false, completion: nil)
    }//func
    
    func resetAction()
    {
        print("clicked")
        let RVC = resetPasswordViewController()
        self.presentViewController(RVC, animated: false, completion: nil)
    }//func
    
    func passwordCheck()
    {
        print("clicked")
        if (self.newPasswordField.text == self.confirmPasswordField.text)
        {
            print("password matches")
            let CVC = confirmPageViewController()
            self.presentViewController(CVC, animated: false, completion: nil)
            
        }
        else
        {
            print("passwords did not match")
        }
        
    }
    
    
    
}