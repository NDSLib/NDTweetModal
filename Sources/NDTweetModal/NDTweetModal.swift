import UIKit
import Photos


public struct NDTweetModal {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

open class NDTweetModalViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    public var tweetBtn: UIButton!
    public var cancelBtn: UIButton!
    
    public var userIconBtn: UIButton!
    public var textView: NDTweetTextView!
    
//    public var cameraBtn: UIButton!
    
    public var collectionView: UICollectionView!
    
    private let reuseIdentifier = "CollectionViewCell"
    private let cameraReuseIdentifier = "CameraCollectionViewCell"
    
    private lazy var assets: PHFetchResult<PHAsset> = {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchOptions.fetchLimit = 20
        return PHAsset.fetchAssets(with: fetchOptions)
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        tweetBtn = UIButton()
        tweetBtn.setTitle("Tweet", for: .normal)
        tweetBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        tweetBtn.backgroundColor = .systemBlue
        tweetBtn.clipsToBounds = true
        tweetBtn.layer.cornerRadius = 18
        view.addSubview(tweetBtn)
        tweetBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        cancelBtn = UIButton()
        cancelBtn.setTitle("Cancel", for: .normal)
//        cancelBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cancelBtn.contentHorizontalAlignment = .left
        view.addSubview(cancelBtn)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        
        userIconBtn = UIButton()
//        userIconBtn.setImage(UIImage(systemName: ""), for: .normal)
        userIconBtn.backgroundColor = .systemGray
        userIconBtn.clipsToBounds = true
        userIconBtn.layer.cornerRadius = 16
        view.addSubview(userIconBtn)
        userIconBtn.translatesAutoresizingMaskIntoConstraints = false
        
        textView = NDTweetTextView()
        textView.placeHolder = "いまどうしてる？"
        textView.textColor = .white
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.backgroundColor = .clear
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
//        cameraBtn = UIButton()
//        cameraBtn.clipsToBounds = true
//        cameraBtn.layer.borderWidth = 1
//        cameraBtn.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor
//        cameraBtn.layer.cornerRadius = 16
//        cameraBtn.setImage(UIImage(systemName: "camera"), for: .normal)
//        cameraBtn.tintColor = .white
//        view.addSubview(cameraBtn)
//        cameraBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 84, height: 84)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(CameraCollectionViewCell.self, forCellWithReuseIdentifier: cameraReuseIdentifier)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        collectionView.register(CameraCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            tweetBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
            tweetBtn.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            tweetBtn.widthAnchor.constraint(equalToConstant: 98),
            tweetBtn.heightAnchor.constraint(equalToConstant: 36),
            
            cancelBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            cancelBtn.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            cancelBtn.widthAnchor.constraint(equalToConstant: 86),
            cancelBtn.heightAnchor.constraint(equalToConstant: 32),
            
            userIconBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            userIconBtn.topAnchor.constraint(equalTo: cancelBtn.bottomAnchor, constant: 12),
            userIconBtn.widthAnchor.constraint(equalToConstant: 32),
            userIconBtn.heightAnchor.constraint(equalToConstant: 32),
            
            textView.leftAnchor.constraint(equalTo: userIconBtn.rightAnchor, constant: 4),
            textView.topAnchor.constraint(equalTo: cancelBtn.bottomAnchor, constant: 8),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 18),
            textView.heightAnchor.constraint(equalToConstant: 128),
            
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -18),
//            collectionView.widthAnchor.constraint(equalToConstant: 84),
            collectionView.heightAnchor.constraint(equalToConstant: 84)
        ])
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let bottom = window?.safeAreaInsets.bottom ?? 0
            print(keyboardSize.height)
            self.collectionView.frame.origin.y = keyboardSize.height + bottom + 18
            print(self.collectionView.frame.origin.y)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }


    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        assets.count + 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cameraReuseIdentifier, for: indexPath)
            return cell
        } else if indexPath.row == assets.count + 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cameraReuseIdentifier, for: indexPath)
            return cell
        }else {
            let asset = assets[indexPath.row - 1]
//            if asset.mediaType == .image {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
            
            
            DispatchQueue.global().async {
                PHCachingImageManager().requestImage(
                    for: asset,
                    targetSize: CGSize(width: 84, height: 84),
                    contentMode: .aspectFill,
                    options: nil
                ) { (image, nil) in

                    // 画像の準備が完了したときに呼び出される
                    DispatchQueue.main.async {
                        cell.imageBtn.setImage(image, for: .normal)
                    }
                }
            }

            
            cell.imageBtn.setImage(UIImage(), for: .normal)
            
            return cell
            
        }
        
//        let cameraBtn = UIButton(frame: cell.bounds)
//        cameraBtn.clipsToBounds = true
//        cameraBtn.layer.borderWidth = 1
//        cameraBtn.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor
//        cameraBtn.layer.cornerRadius = 16
//        cameraBtn.setImage(UIImage(systemName: "camera"), for: .normal)
//        cameraBtn.tintColor = .white
//
//        cell.addSubview(cameraBtn)
        
    }
}

class CollectionViewCell: UICollectionViewCell {
    public var imageBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageBtn = UIButton(frame: bounds)
        imageBtn.clipsToBounds = true
        imageBtn.layer.borderWidth = 1
        imageBtn.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor
        imageBtn.layer.cornerRadius = 16
//      imageBtn.setImage(, for: .normal)
        imageBtn.tintColor = .white
        
        addSubview(imageBtn)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CameraCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cameraBtn = UIButton(frame: bounds)
        cameraBtn.clipsToBounds = true
        cameraBtn.layer.borderWidth = 1
        cameraBtn.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor
        cameraBtn.layer.cornerRadius = 16
        cameraBtn.setImage(UIImage(systemName: "camera"), for: .normal)
        cameraBtn.tintColor = .white
        
        addSubview(cameraBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
