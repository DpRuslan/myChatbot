//
// TextCell
//

struct TextMessage {
    var isSending: Bool
    var text: String
}

import UIKit

// MARK: UITableViewCell

class TextCell: UITableViewCell {
    let chatLabel = UILabel()
    let roundedView = UIView()
    var roundedViewLeading: NSLayoutConstraint!
    var roundedViewTrailing: NSLayoutConstraint!
    var chatMessage: TextMessage! {
        didSet {
            if chatMessage.isSending {
                roundedView.backgroundColor = UIColor.black
                roundedViewLeading.isActive = false
                roundedViewTrailing.isActive = true
            } else {
                roundedView.backgroundColor = UserDefaults.standard.object(forKey: "Theme") as? Int == 0 ? UIColor(red: 66/255, green: 91/255, blue: 218/255, alpha: 1) :
                    UIColor(red: 232/255, green: 197/255, blue: 71/255, alpha: 1)
                roundedViewLeading.isActive = true
                roundedViewTrailing.isActive = false
            }
            
            setupUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(roundedView)
        roundedView.addSubview(chatLabel)
        
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        chatLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: setupConstraints

extension TextCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            roundedView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            roundedView.widthAnchor.constraint(lessThanOrEqualToConstant: self.bounds.width),
            
            chatLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 10),
            chatLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 10),
            chatLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -10),
            chatLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -10)
        ])
        
        roundedViewLeading = roundedView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        roundedViewTrailing = roundedView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
    }
}

// MARK: CustomLabel

extension TextCell: CustomLabel {
    private func setupUI() {
        roundedView.layer.cornerRadius = 15
        
        setCustomLabel(
            label: chatLabel,
            title: chatMessage.text,
            fontSize: 14,
            textColor: .white,
            numbersOfLines: 0,
            alignment: nil
        )
    }
}
