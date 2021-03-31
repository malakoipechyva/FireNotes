//
//  NoteCell.swift
//  FireNotes
//
//  Created by malakoipechyva on 31.03.21.
//

import UIKit

class NoteCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Note Title"
        return label
    }()
    
    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "00.00.00 march"
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [noteLabel, timestampLabel])
        stack.axis = .vertical
        stack.spacing = 5
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - API
    
    //MARK: - Helpers
    
}
