import SwiftUI
import FirebaseAuth

// Tela com o formulário para realizar o login
struct LoginView: View {
    // Estados para guardar o email e a password através do user input
    @State private var email: String = ""
    @State private var password: String = ""
    // Binding para controlar o estado da visualização atual
    @Binding var currentView: String
    // Armazenamento local para o ID do user após o login bem sucedido
    @AppStorage("uid") var userID: String = ""
    
    //  Função privada para validar a complexidade da password
    private func isValidPassword(_ password: String) -> Bool{
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)
    }
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Text("Login")
                        .font(.title)
                        .bold()
                    Spacer()
                    
                }
                .padding()
                .padding(.top)
                Spacer()
                
                HStack{
                    // Campo para o user input do email
                    TextField("Email", text: $email)
                    Spacer()
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                
                HStack{
                    // Campo seguro para o user input da password
                    SecureField("Password", text: $password)
                    Spacer()
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                Button(action: {
                    withAnimation{
                        // Alterar a tela para a tela de signup ao pressionar o botão
                        self.currentView = "signup"
                    }
                }){
                    Text("Criar Conta?")
                        .foregroundColor(.blue.opacity(0.8))
                }
                Spacer()
                
                // Botão para fazer login
                Button{
                    Auth.auth().signIn(withEmail: email, password: password){ authResult, error in
                        if let error = error{
                            // Mostra o erro caso haja algum
                            print(error)
                            return
                        }
                        if let authResult = authResult{
                            // Imprime o ID do user após o signup bem sucedido
                            print(authResult.user.uid)
                            withAnimation{
                                // Armazena o ID do user no AppStorage
                                userID = authResult.user.uid
                                // Altera para a tela meteorológica
                                self.currentView = "weather"
                            }
                        }
                    }
                }label: {
                    Text("Login")
                        .foregroundColor(.blue)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black)
                        )
                }
            }
        }
    }
}
