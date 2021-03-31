//
//  NotesController.swift
//  FireNotes
//
//  Created by malakoipechyva on 23.03.21.
//

import UIKit

private let reuseIdentifier = "NoteCell"

class NotesController: UITableViewController {
    
    //MARK: - Properties
    
    private var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "Plus_Circle"), for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
        fetchNotes()
    }
    
    //MARK: - Selectors
    
    @objc func addNoteButtonTapped() {
        let nav = UINavigationController(rootViewController: UploadNoteController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    //MARK: - API
    
    func fetchNotes() {
        NoteService.shared.fetchNotes { notes in
            self.notes = notes
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Notes"
        
        view.addSubview(addNoteButton)
        addNoteButton.centerX(inView: view)
        addNoteButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
        
        tableView.register(NoteCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a notes"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

//MARK: - UITableViewDataSource/Delegate

extension NotesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        cell.note = note
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let controller = DetailNoteController(note: note)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UISearchResultsUpdating

extension NotesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        print("DEBUG: searched text is \(searchText)")

    }
}
