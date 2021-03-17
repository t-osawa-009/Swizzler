import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        button4.addTarget(self, action: #selector(button4Tapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        
    }
    
    @IBAction func button2Tapped(_ sender: Any) {
        
    }
    
    @IBAction func button3Tapped(_ sender: Any) {
        
    }
    
    @objc private func button4Tapped(_ sender: Any) {
        
    }
    
    @IBOutlet private weak var button4: UIButton! {
        didSet {
            button4.eventNameType = .button4
        }
    }
}

