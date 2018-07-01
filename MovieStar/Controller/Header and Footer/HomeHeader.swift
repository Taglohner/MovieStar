
import UIKit

class StyleOneHeader: UICollectionReusableView {
    
    var title: String? {
        didSet {
            guard let title = title else { return }
        
            let attributedText = NSAttributedString(string: "\(title)", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 28) ??  UIFont.systemFont(ofSize: 20)])
            nameLabel.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seeMoreButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSAttributedString(string: "See More", attributes: [NSAttributedStringKey.foregroundColor: UIColor.yellow, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    func setupViews() {
        backgroundColor = .darkGray
        [nameLabel, seeMoreButton].forEach { addSubview($0) }

        seeMoreButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 4, right: 10))
        nameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    }
}

