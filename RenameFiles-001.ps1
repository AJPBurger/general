##
## Read list of .excel files and remove .xls file
##
$InputFile = 'C:\Users\ABurger\Desktop\excel.csv'

Foreach($line in (Get-Content $InputFile))
{
    Write-Host 'Read: ',$line -foregroundcolor DarkGreen -backgroundcolor white
    $data = $line.split(',');
    $FolderPath = $data[0]
    $FileName = $data[0]
    $FileNameEXCEL = $data[1] + '.excel'
    $FileNameXLS = $data[1] + '.xls'
    Write-Host 'File Name Excel = ',$FileNameEXCEL,' File Name XLS = ',$FileNameXLS
    $strFileNameXLS = $FolderPath+'\'+$FileNameXLS
    $strFileNameEXCEL = $FolderPath+'\'+$FileNameEXCEL
    # Write-Host 'Removing: ',$strFileNameXLS
    Write-Host "Testing for ",$strFileNameXLS
    if(Test-Path "$strFileNameXLS"){
        Write-Host "Found XLS file" -foregroundcolor DarkGreen -backgroundcolor white
        Write-Host "Testing for ",$strFileNameEXCEL
        If(Test-Path "$strFileNameEXCEL") {
            Write-Host 'Both Excel and XLS file exists. Removing: ',$strFileNameXLS, " and Renaming ",$strFileNameEXCEL -foregroundcolor red -backgroundcolor white
            #Remove-Item $strFileNameXLS -WhatIf
            #Rename-Item -Newname $strFileNameXLS -WhatIf
        } else {
            Write-Host "Test for EXCEL existence failed" -ForegroundColor white
            Write-Host "Renaming ",$FileNameEXCEL," to ",$FileNameXLS    
        }
    }
    #else {
        #Write-Host "Test for XLS existence failed - but EXCEL file exists!" -ForegroundColor white
        #Write-Host "Renaming ",$FileNameEXCEL," to ",$FileNameXLS
        #Rename-Item -Newname $strFileNameXLS -WhatIf
    #}
}