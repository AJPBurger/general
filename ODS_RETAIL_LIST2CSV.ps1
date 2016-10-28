Get-ChildItem -Path O:\ODS_RETAIL -Recurse |`
foreach{
$Item = $_
$Type = $_.Extension
$Path = $_.FullName
$Folder = $_.PSIsContainer
$Age = $_.CreationTime

$Path | Select-Object `
    @{n="Name";e={$Item}},`
    @{n="Created";e={$Age}},`
    @{n="filePath";e={$Path}},`
    @{n="Extension";e={if($Folder){"Folder"}else{$Type}}}`
}| Export-Csv O:\ODS_RETAIL\Results.csv -NoTypeInformation 