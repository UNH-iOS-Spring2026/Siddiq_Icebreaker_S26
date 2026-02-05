//
//  ContentView.swift
//  Siddiq_Icebreaker_S26
//
//  Created by Mohammed Mustafa Siddiq on 2/4/26.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    let db  = Firestore.firestore()
    @State private var txtFirstName: String = ""
    @State private var txtLastName: String = ""
    @State private var txtPreferredName: String = ""
    @State private var txtQuestion: String = ""
    @State private var txtAnswer: String = ""
    @State var questions = [Question]()
    var body: some View {
        
        
        VStack {
            Text("Ice breaker")
                .bold()
                .font(.system(size: 40))
            Text("Made by Mustafa")
            //.font(.system(size: 24))
            TextField("First Name", text: $txtFirstName)
            TextField("Last Name", text: $txtLastName)
            TextField("Prefered Name", text: $txtPreferredName)
            Button {
                setRandomQuestion()
            } label: {
                Text("Get a new random question")
            }
            Text(txtQuestion)
            TextField("Answer ", text: $txtAnswer)
            Button {
                writeStudentToFirebase()
                resetTxtFields()
            } label: {
                Text("Submit")
            }
            Spacer()
        }
        .font(.system(size: 28))
        .padding()
        .multilineTextAlignment(.center)
        .onAppear(){ getQuestionsFromFirebase()   }
    }
    func setRandomQuestion() {
        let newQuestion = questions.randomElement()?.text
        if (newQuestion != nil){
            self.txtQuestion = newQuestion!
        }
        
    }
    func getQuestionsFromFirebase() {
        db.collection("questions")
            .getDocuments(){(QuerySnapshot, err) in
                if let err = err { //error not nil
                    print("Error getting documents: \(err)")
                }else {
                    for document in QuerySnapshot!.documents {
                        print("Document ID: \(document.documentID)")
                        if let question = Question(id:document.documentID, data:document.data()){
                            print("Question ID: \(question.id), text = \(question.text)")
                            self.questions.append(question)
                        }
                    }
                }
            }
    }
    func writeStudentToFirebase(){
        let data = [
            "first_name" : txtFirstName,
            "last_name" : txtLastName,
            "pref_name" : txtPreferredName,
            "question" : txtQuestion,
            "answer" : txtAnswer,
            "class"  : "iOS-Spring2026"
        ] as [String : Any]
        
        var ref: DocumentReference? = nil
        
        ref = db.collection("students")
            .addDocument(data: data) { err in
                if let err = err {
                    print("error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
    }
    func resetTxtFields(){
            txtFirstName = ""
            txtLastName = ""
            txtPreferredName = ""
            txtAnswer = ""
            txtQuestion = ""
        }
}

#Preview {
    ContentView()
}

