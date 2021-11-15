import UIKit


public struct NDTweetModal {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

open class NDTweetModalViewController: UIViewController {
    public var tweetBtn: UIButton!
    public var cancelBtn: UIButton!
    
    public var userIconBtn: UIButton!
    public var textView: NDTweetTextView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        tweetBtn = UIButton()
        tweetBtn.setTitle("Tweet", for: .normal)
        tweetBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        tweetBtn.backgroundColor = .systemBlue
        tweetBtn.clipsToBounds = true
        tweetBtn.layer.cornerRadius = 19
        view.addSubview(tweetBtn)
        tweetBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        cancelBtn = UIButton()
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cancelBtn.titleLabel?.textAlignment = .left
        view.addSubview(cancelBtn)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        
        userIconBtn = UIButton()
//        userIconBtn.setImage(UIImage(systemName: ""), for: .normal)
        userIconBtn.backgroundColor = .systemGray
        userIconBtn.clipsToBounds = true
        userIconBtn.layer.cornerRadius = 19
        view.addSubview(userIconBtn)
        userIconBtn.translatesAutoresizingMaskIntoConstraints = false
        
        textView = NDTweetTextView()
        textView.placeHolder = "いまどうしてる？"
        textView.textColor = .white
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.backgroundColor = .clear
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            tweetBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
            tweetBtn.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            tweetBtn.widthAnchor.constraint(equalToConstant: 86),
            tweetBtn.heightAnchor.constraint(equalToConstant: 38),
            
            cancelBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            cancelBtn.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            cancelBtn.widthAnchor.constraint(equalToConstant: 86),
            cancelBtn.heightAnchor.constraint(equalToConstant: 38),
            
            userIconBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            userIconBtn.topAnchor.constraint(equalTo: cancelBtn.bottomAnchor, constant: 12),
            userIconBtn.widthAnchor.constraint(equalToConstant: 38),
            userIconBtn.heightAnchor.constraint(equalToConstant: 38),
            
            textView.leftAnchor.constraint(equalTo: userIconBtn.rightAnchor, constant: 12),
            textView.topAnchor.constraint(equalTo: cancelBtn.bottomAnchor, constant: 12),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 18),
            textView.heightAnchor.constraint(equalToConstant: 128)
        ])
        
        
    }
}


#if DEBUG
import SwiftUI

struct NDTweetModalViewController_Wrapper: UIViewControllerRepresentable {
    typealias ViewControllerType = NDTweetModalViewController
  func makeUIViewController(context: Context) -> ViewControllerType {
      return NDTweetModalViewController ()
  }

  func updateUIViewController(_ uiViewController: ViewControllerType,
    context: Context) {
  }
}

struct ShareViewController_Preview: PreviewProvider {
    
    static let devices = [
//      "iPhone SE (2nd generation)",
      "iPhone 11"
    ]

    static var previews: some View {
//        Group {
//            ForEach(devices, id: \.self) { name in
        NDTweetModalViewController_Wrapper()
//              .previewDevice(PreviewDevice(rawValue: name))
//              .previewDisplayName(name)
//            }
//        }
    }
}
#endif
