import UIKit
class LoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITableViewDelegate, UITableViewDataSource
{
    
    let button = UIButton()
    let resetPasswordButton = UIButton()
    let printButton = UIButton()
    let userListButton = UIButton()
    let exampleTitle = UILabel()
    var userArray: [String] = []
    var emailArray: [String] = []
    

    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let tableView: UITableView  =   UITableView()
        tableView.frame  =  CGRectMake(0, 50, 320, 200);
        tableView.delegate  =  self
        tableView.dataSource    =   self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        
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
        
        
        //Create table view
     
        
        //Retrieve list of all users
        
        
        let query:PFQuery=PFQuery(className: "_User");
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            if !(error != nil) {
                for(var i=0;i<objects!.count;i++){
                    let object=objects![i] as! PFObject;
                    let name = object.objectForKey("username") as! String;
                    let email = object.objectForKey("email") as! String;
                    self.userArray.append(name)
                    self.emailArray.append(email)
                    tableView.reloadData()
                    
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
    }//func
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
            reuseIdentifier: "cell") as UITableViewCell
        
        
        cell.textLabel?.text = userArray[indexPath.row]
        cell.detailTextLabel?.text = emailArray[indexPath.row]
        return cell
        
        
    }
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
    
    
    

}
    //LoginViewController