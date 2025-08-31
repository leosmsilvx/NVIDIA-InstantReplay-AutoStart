$scriptFolder = if ($MyInvocation.MyCommand.Path) { 
    Split-Path -Parent $MyInvocation.MyCommand.Path 
} else { 
    (Get-Location).Path 
}

$logFile = Join-Path -Path $scriptFolder -ChildPath "log.txt"

Try {
    "$(Get-Date) INFO - Script iniciado" | Out-File $logFile -Append

    $logPath = "$env:LOCALAPPDATA\NVIDIA Corporation\NVIDIA Overlay\console.log"
    $hotkey = "+%{F10}"

    "$(Get-Date) INFO - Criando wscript.shell" | Out-File $logFile -Append
    $wshell = New-Object -ComObject wscript.shell

    "$(Get-Date) INFO - Mandando Alt+Shift+F10" | Out-File $logFile -Append
    $wshell.SendKeys($hotkey)

    if (Test-Path $logPath) {
        Start-Sleep -Seconds 1
        $lastLines = Get-Content $logPath -Tail 100
        "$(Get-Date) INFO - Validando NVIDIA Overlay\console.log" | Out-File $logFile -Append
        if ($lastLines -match "ShadowPlayService  IR Disabled") {
            "$(Get-Date) INFO - O ShadowPlayService IR foi desabilitado" | Out-File $logFile -Append
            "$(Get-Date) INFO - Mandando Alt+Shift+F10" | Out-File $logFile -Append
            $wshell.SendKeys($hotkey)
        }
    }
    "$(Get-Date) INFO - Script finalizado" | Out-File $logFile -Append
}
Catch {
    "$(Get-Date) ERRO - $($_.Exception.Message)" | Out-File $logFile -Append
}
"-------------------------------------------------------------------------" | Out-File $logFile -Append
