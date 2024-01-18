import SwiftUI
import FirebaseCore

// Define a aplicação principal
@main
struct Tempo2App: App {
    
    // Inicia a aplicação configurando a Firebase
    init(){
        FirebaseApp.configure()
    }
    // Define a estrutura principal da aplicacão
    var body: some Scene {
        WindowGroup {
            // Define o conteúdo principal a ser exibido
            ContentView()
        }
    }
}
