

$Host.UI.RawUI.WindowTitle = "BSOD"
$Host.UI.RawUI.BackgroundColor = "DarkBlue"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

if ($args[0] -eq "--qrcode") {
    @"



                    :(
                    Your PC ran into a problem and needs to restart. We're
                    just collecting some error info, and then we'll restart
                    for you.



                    0% complete



"@
    
    $qrcode = qrencode -t UTF8 -i -m 0 -s 2 "https://windows.com/stopcode" 2>$null
    if ($qrcode) {
        $lines = $qrcode -split "`n"
        $width = $Host.UI.RawUI.WindowSize.Width
        foreach ($line in $lines) {
            $padding = [math]::Max(0, ($width - $line.Length) / 2)
            Write-Host (" " * [math]::Floor($padding)) + $line
        }
    }
    
    @"



                    If you call a support person, give them this info:
                    Stop code: CRITICAL_PROCESS_DIED



"@
} else {
    @"



                    :(
                    Your PC ran into a problem and needs to restart. We're
                    just collecting some error info, and then we'll restart
                    for you.



                    0% complete



                    For more information about this issue and possible
                    fixes, visit https://windows.com/stopcode



                    If you call a support person, give them this info:
                    Stop code: CRITICAL_PROCESS_DIED



"@
}

for ($i = 0; $i -le 100; $i++) {
    Write-Host -NoNewline ("`r                    {0}% complete" -f $i)
    Start-Sleep -Milliseconds 50
}

Write-Host "`n`n"
Start-Sleep -Seconds 2
Clear-Host
