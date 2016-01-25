import UIKit
class LoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate
{
    
    let button = UIButton()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(button)
        button.backgroundColor = UIColor.darkGrayColor()
        button.centerHorizontallyInSuperview()
        button.sizeToHeight(40)
        button.sizeToWidth(500)
        button.setTitle("Logout", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        button.centerInSuperview()
        button.addTarget(self, action: "logoutAction", forControlEvents: .TouchUpInside)
        
        
        // Do any additional setup after loading the view.
    }//func
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//func
    
    //MARK: Parse Login
    //If no user logged in then parse login view opens
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
    
}//LoginViewController