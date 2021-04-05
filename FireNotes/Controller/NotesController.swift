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
    
    private var filteredNotes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: BooleanLiteralType {
        return searchController.isActive &&
            !searchController.searchBar.text!.isEmpty
    }
    
    private let addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "Plus_Circle"), for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .amber
        button.setImage(UIImage(named: "square_arrow_right"), for: .normal)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        configureUI()
        fetchNotes()
    }
    
    //MARK: - Selectors
    
    @objc func addNoteButtonTapped() {
        let nav = UINavigationController(rootViewController: UploadNoteController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func logOutButtonTapped() {
        let logOutAlert = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: UIAlertController.Style.alert)

        logOutAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let controller = LoginController()
            AuthService.shared.logUserOut()
            self.navigationController?.pushViewController(controller, animated: true)
        }))

        logOutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(logOutAlert, animated: true, completion: nil)
    }
    
    //MARK: - API
    
    func fetchNotes() {
        NoteService.shared.fetchNotes { notes in
            let chronoNotes = notes.sorted {$0.timestamp > $1.timestamp}
            self.notes = chronoNotes
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logOutButton)
        
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
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

//MARK: - UITableViewDataSource/Delegate

extension NotesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredNotes.count : notes.count
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

        filteredNotes = notes.filter({ $0.text.contains(searchText)})

    }
}
