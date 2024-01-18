import SwiftUI

// Tela que gerencia a exibição tanto da tela de login como da tela signup, dependendo do estado atual
struct AuthView: View {
    // Estado que controla qual a tela que será exibida
    @State private var currentView: String = "login"
    var body: some View {
        if(currentView == "login"){
            LoginView(currentView: $currentView)
        }else{
            SignUpView(currentView: $currentView)
        }
    }
}

#Preview {
    // Previsualização da tela de autenticação
    AuthView()
}
