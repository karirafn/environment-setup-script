@(
    '7zip.7zip'
    'Git.Git'
    'Google.AndroidStudio'
    'Google.Chrome'
    'JGraph.Draw'
    'Microsoft.OneDrive'
    'Microsoft.PowerShell'
    'Microsoft.VisualStudioCode'
    'Microsoft.VisualStudio.2022.Community',
    'Microsoft.WindowsTerminal'
    'Notepad++.Notepad++'
    'OpenJS.NodeJS'
    'Skillbrains.Lightshot'
    'Telerik.Fiddler.Classic'
) | ForEach-Object {
    $name = $_

    Write-Host "Determining action for $name ... " -NoNewline

    $list = winget list $name --exact
    $versions = $list -split ' ' | Where-Object { $_ -match '^(\d+[.]|\d+[.]\d+)+$' } | Get-Unique
    $versionCount = ($versions | Measure-Object).Count

    $action = switch($versionCount) {
        0 { 'install' }
        2 { 'upgrade' }
        default { 'none' }
    }

    Write-Host $action

    if ($action -eq 'none') { return }

    winget $action $name --silent --accept-package-agreements --accept-source-agreements
 }
