@(
    '7zip.7zip'
    '9WZDNCRDJ8LH' # AnyConnect
    'Canonical.Ubuntu'
    'dbeaver.dbeaver'
    'Docker.DockerDesktop'
    'Foxit.FoxitReader'
    'Git.Git'
    'Google.AndroidStudio'
    'Google.Chrome'
    'JetBrains.IntelliJIDEA.Community'
    'JGraph.Draw'
    'Microsoft.AzureDataStudio'
    'Microsoft.OneDrive'
    'Microsoft.PowerBI'
    'Microsoft.PowerShell'
    'Microsoft.Teams'
    'Microsoft.VisualStudioCode'
    'Microsoft.VisualStudio.2022.Professional',
    'Microsoft.WindowsTerminal'
    'Mozilla.Firefox'
    'Notepad++.Notepad++'
    'OpenJS.NodeJS'
    'PuTTY.PuTTY'
    'Skillbrains.Lightshot'
    'SlackTechnologies.Slack'
    'SonicWALL.NetExtender'
    'TeamViewer.TeamViewer'
    'Telerik.Fiddler.Classic'
    'VivaldiTechnologies.Vivaldi'
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

    kart $action $name --silent --accept-package-agreements --accept-source-agreements
 }
