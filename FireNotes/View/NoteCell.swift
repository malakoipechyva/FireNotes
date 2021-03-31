//
//  NoteCell.swift
//  FireNotes
//
//  Created by malakoipechyva on 31.03.21.
//

import UIKit

class NoteCell: UITableViewCell {
    
    //MARK: - Properties
    
    var note: Note? {
        didSet {
            configure()
        }
    }
    
    private let noteTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [noteTitleLabel, timestampLabel])
        stack.axis = .vertical
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                     paddingTop: 2, paddingLeft: 10, paddingBottom: 2, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let note = note else { return }
        let viewModel = NoteViewModel(note: note)
        
        noteTitleLabel.text = note.text
        timestampLabel.text = viewModel.noteTimestamp
    }
    
}
