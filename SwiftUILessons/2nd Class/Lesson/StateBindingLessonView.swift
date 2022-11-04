//
//  StateBindingLessonView.swift
//  SwiftUILessons
//
//  Created by Alessandro Pace on 3/11/22.
//

import SwiftUI

/// @STate, @Binding && @Published lesson
struct StateBindingLessonView: View {
    
    // ViewModel
    @ObservedObject var viewModel = StateBindingLessonViewModel()
    
    // Screen state controll
    @State private var buttonColorIndigo: Bool = false
    
    // Fields
    @State private var showPassword: Bool = false
    @State private var termsAccepted: Bool = false
    
    var body: some View {
        VStack {
            Text("Hello Again!")
                .font(.title.bold())
                .padding(.top, 50)
                .padding(.bottom, 10)
            
            Text("Welcome back \(viewModel.name) you've been missed!")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            TextField("Enter username", text: $viewModel.userName)
                .padding(.top, 50)
            
            
            Group {
                if showPassword {
                    TextField("Password", text: $viewModel.password)
                } else {
                    SecureField("Password", text: $viewModel.password)
                }
            }
            .overlay(
                Button(action: {
                    showPassword.toggle()
                }, label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash").padding(.trailing, 10)
                        .foregroundColor(.indigo)
                }), alignment: .bottomTrailing)
            .padding(.vertical, 10)
            
            PasswordTextFieldView(password: $viewModel.password)
            
            HStack {
                Spacer()
                
                Text("Recovery Password")
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 50)
            
            Button("Sign in") {
                // NOTHING
            }
            .font(.body.bold())
            .foregroundColor(.white)
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .background(buttonColorIndigo ? Color.indigo : Color.black)
            .cornerRadius(15)
            .padding(.bottom, 20)
            
            Toggle("Indigo button", isOn: $buttonColorIndigo)
                .tint(Color.indigo)
                .padding(.bottom, 20)
                .font(.body.bold())
            
            Spacer()
            
        }
        .padding(.horizontal, 20)
        
    }
    
}

struct StateBindingLessonView_Previews: PreviewProvider {
    static var previews: some View {
        StateBindingLessonView()
    }
}

/// View Model
class StateBindingLessonViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var password: String = ""
    
    var name: String {
        return userName.isEmpty ? "User" : userName
    }
}


/// Binding Example
struct PasswordTextFieldView: View {
    
    @Binding var password: String
    @State private var showPassword = false
    
    var body: some View {
        Group {
            if showPassword {
                TextField("Password", text: $password)
            } else {
                SecureField("Password", text: $password)
            }
        }
        .overlay(
            Button(action: {
                showPassword.toggle()
            }, label: {
                Image(systemName: showPassword ? "eye" : "eye.slash").padding(.trailing, 10)
                    .foregroundColor(.indigo)
            }), alignment: .bottomTrailing)
        .padding(.vertical, 10)
    }
    
}
