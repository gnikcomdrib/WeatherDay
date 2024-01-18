import SwiftUI

// Tela para exibir o indicador de carregamento
struct LoadingView: View {
    var body: some View {
        // Exibe um inicador de carregamento
        ProgressView()
        // Define o estilo do indicador de carregamento
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
        // Ocupa a tela por completo
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    // Previsualização da tela de carregamento
    LoadingView()
}
