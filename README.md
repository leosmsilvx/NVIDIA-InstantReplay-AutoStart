# NVIDIA Instant Replay AutoStart

Este script PowerShell garante que o **NVIDIA Instant Replay (ShadowPlay)** esteja sempre ativo ao iniciar o Windows. Ele envia automaticamente a hotkey configurada para iniciar o Instant Replay caso ele esteja desativado.

---

## Requisitos

- Sistema Windows
- NVIDIA Overlay/GeForce Experience instalado
- Bind configurada para **SHIFT + ALT + F10** para iniciar o Instant Replay

---

## Configuração da Tarefa Agendada

1. Abra o **Task Scheduler (Agendador de Tarefas)** no Windows.  
2. Crie uma nova tarefa com os seguintes parâmetros:

### Geral
- **Executar somente quando o usuário estiver conectado**  
- **Executar com privilégios mais altos**

### Disparadores
- **Ao fazer logon**

### Ação
- **Iniciar um programa**
  - Programa/Script: `powershell.exe`
  - Adicionar argumentos (opcional):  
    ```text
    -WindowStyle Hidden -ExecutionPolicy Bypass -File "nvidia.ps1"
    ```
  - Iniciar em (opcional): Pasta onde o `nvidia.ps1` se encontra

---

## Como funciona

1. Ao fazer logon, o script é executado pelo Task Scheduler.  
2. Ele cria um objeto `WScript.Shell` e envia a hotkey para ativar o NVIDIA Instant Replay.  
3. Se o serviço já estiver desativado, ele envia a hotkey novamente após checar o log do NVIDIA Overlay.  
4. Todas as ações são registradas em `log.txt` para acompanhamento.

