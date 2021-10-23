//
//  DetailViewController.swift
//  TodoApp
//
//  Created by Ali Kose on 20.10.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var deadlineDateTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var datePicker = UIDatePicker()
    var viewModel : DetailViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didLoad()
        self.hideKeyboardWhenTappedAround()
        createDatePicker()
        button.moveKeyboard()
        backButton.setTitle("", for: .normal)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        viewModel.goBack()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let title = titleTextField.text,
              let detail = detailTextView.text,
              let deadLineDate = deadlineDateTextField.text
        else {print("Veriler opsiyonelden cikti"); return}
        viewModel.addTodo(title: title , detail: detail, deadlineDate: deadLineDate, date: datePicker.date)
    }
}

// MARK: VIEWMODEL DELEGATE - OUTPUTS
extension DetailViewController : DetailViewModelDelegate {
    
    func handleOutput(_ output: ViewModelOutput) {
        
        switch output {
            
        case .showToDoDetail(let toDoPresentation):
            titleTextField.text = toDoPresentation.title
            detailTextView.textColor = .black
            detailTextView.text = toDoPresentation.detail
            deadlineDateTextField.text = toDoPresentation.deadlineDate
            navigationLabel.text = "Hedef Bilgilerini Düzenle"
            button.setTitle("Güncelle", for: .normal)
        
        case .showToDoAdd:
            navigationLabel.text = "Hedefini Ekle"
            titleTextField.placeholder = "Hedefin ne?"
            detailTextView.text = "Lütfen Buraya Hedef Detaylarını Yaz."
            deadlineDateTextField.placeholder = "Hedefin Geçerlilik Tarihi Seçiniz."
            button.setTitle("Hedefini Ekle", for: .normal)
            
        case .showAlert:
            let alert = UIAlertController(title: "Hedef Başlığı Boş Olamaz", message: "Lütfen Tüm Alanları  Doldurun", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func navigate(to route: DetailViewRouter) {
        switch route {
        case .goBack:
            self.navigationController?.popToRootViewController(animated: true)
        case .saveAndBack:
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

//MARK: - TEXT VIEW DELEGATE CONFIGURATION

extension DetailViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if  detailTextView.text == "Lütfen Buraya Hedef Detaylarını Yaz." {
            detailTextView.textColor = .label
            detailTextView.text = ""
        }
    }
}

//MARK: - DATE PICKER CONFIGURATION

extension DetailViewController {
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: #selector(clearButtonTapped))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTapped))
        
        toolbar.setItems([clearButton,spaceButton,doneButton], animated: true)
        deadlineDateTextField.inputAccessoryView = toolbar
        datePicker.preferredDatePickerStyle = .wheels
        deadlineDateTextField.inputView = datePicker
    }
    
    @objc func doneButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        let date =  formatter.string(from: datePicker.date)
        deadlineDateTextField.text = date
        self.view.endEditing(true)
    }
    @objc func clearButtonTapped() {
        deadlineDateTextField.text = "Lütfen Buraya Hedef Detaylarını Yaz."
        self.view.endEditing(true)
    }
}
