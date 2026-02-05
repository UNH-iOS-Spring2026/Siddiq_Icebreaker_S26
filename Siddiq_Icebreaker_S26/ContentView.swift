//
//  ContentView.swift
//  Siddiq_Icebreaker_S26
//
//  Created by Mohammed Mustafa Siddiq on 2/4/26.
//

import SwiftUI

struct ContentView: View {
    @State private var txtFirstName: String = ""
    @State private var txtLastName: String = ""
    @State private var txtPreferredName: String = ""
    @State private var txtAnswer: String = ""
    var body: some View {

        VStack {
            Text("Ice breaker")
                .bold()
                .font(.system(size: 40))
            Text("Made by Mustafa")
//                .font(.system(size: 24))
            TextField("First Name", text: $txtFirstName)
            TextField("Last Name", text: $txtLastName)
            TextField("Prefered Name", text: $txtPreferredName)
            Button {
            } label: {
                Text("Get a new random question")
            }
            Text("Question")
            TextField("Answer ", text: $txtAnswer)
            Button {
                print("First Name: \(txtFirstName)")
                print("First Name: \(txtLastName)")
                print("First Name: \(txtPreferredName)")
                print("First Name: \(txtAnswer)")
            } label: {
                Text("Submit")
            }
            Spacer()
        }
        .font(.system(size: 28))
        .padding()
        .multilineTextAlignment(.center)
    }
}
