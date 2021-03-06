﻿#requires -version 2.0
## ISE-Comments module v 1.1
##############################################################################################################
## Provides Comment cmdlets for working with ISE
## ConvertTo-BlockComment - Comments out selected text with <# before and #> after
## ConvertTo-BlockUncomment - Removes <# before and #> after selected text
## ConvertTo-Comment - Comments out selected text with a leeding # on every line 
## ConvertTo-Uncomment - Removes leeding # on every line of selected text
##
## Usage within ISE or Microsoft.PowershellISE_profile.ps1:
## Import-Module ISE-Comments.psm1
##
## Note: The IsePack, a part of the PowerShellPack, also contains a "Toggle Comments" command,
##       but it does not support Block Comments
##       http://code.msdn.microsoft.com/PowerShellPack
##
##############################################################################################################
## History:
## 1.1 - Minor alterations to work with PowerShell 2.0 RTM and Documentation updates (Hardwick)
## 1.0 - Initial release (Poetter)
##############################################################################################################


## ConvertTo-BlockComment
##############################################################################################################
## Comments out selected text with <# before and #> after
## This code was originaly designed by Jeffrey Snover and was taken from the Windows PowerShell Blog.
## The original function was named ConvertTo-Comment but as it comments out a block I renamed it.
##############################################################################################################
function ConvertTo-BlockComment
{
    $editor = $psISE.CurrentFile.Editor
    $CommentedText = "<#`n" + $editor.SelectedText + "#>"
    # INSERTING overwrites the SELECTED text
    $editor.InsertText($CommentedText)
}

## ConvertTo-BlockUncomment
##############################################################################################################
## Removes <# before and #> after selected text
##############################################################################################################
function ConvertTo-BlockUncomment
{
    $editor = $psISE.CurrentFile.Editor
    $CommentedText = $editor.SelectedText -replace ("^<#`n", "")
    $CommentedText = $CommentedText -replace ("#>$", "")
    # INSERTING overwrites the SELECTED text
    $editor.InsertText($CommentedText)
}

## ConvertTo-Comment
##############################################################################################################
## Comments out selected text with a leeding # on every line
##############################################################################################################
function ConvertTo-Comment
{
    $editor = $psISE.CurrentFile.Editor
    $CommentedText = $editor.SelectedText.Split("`n")
    # INSERTING overwrites the SELECTED text
    $editor.InsertText( "#" + ( [String]::Join("`n#", $CommentedText)))
}

## ConvertTo-Uncomment
##############################################################################################################
## Comments out selected text with <# before and #> after
##############################################################################################################
function ConvertTo-Uncomment
{
    $editor = $psISE.CurrentFile.Editor
    $CommentedText = $editor.SelectedText.Split("`n") -replace ( "^#", "" )
    # INSERTING overwrites the SELECTED text
    $editor.InsertText( [String]::Join("`n", $CommentedText))
}

##############################################################################################################
## Inserts a submenu Comments to ISE's Custum Menu
## Inserts command Block Comment Selected to submenu Comments
## Inserts command Block Uncomment Selected to submenu Comments
## Inserts command Comment Selected to submenu Comments
## Inserts command Uncomment Selected to submenu Comments
##############################################################################################################
if (-not( $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus | where { $_.DisplayName -eq "Comments" } ) )
{
	$commentsMenu = $psISE.CurrentPowerShellTab.AddOnsMenu.SubMenus.Add("_Comments",$null,$null) 
	$null = $commentsMenu.Submenus.Add("Block Comment Selected", {ConvertTo-BlockComment}, "Ctrl+SHIFT+B")
	$null = $commentsMenu.Submenus.Add("Block Uncomment Selected", {ConvertTo-BlockUncomment}, "Ctrl+Alt+B")
	$null = $commentsMenu.Submenus.Add("Comment Selected", {ConvertTo-Comment}, "Ctrl+SHIFT+C")
	$null = $commentsMenu.Submenus.Add("Uncomment Selected", {ConvertTo-Uncomment}, "Ctrl+Alt+C")
}

# If you are using IsePack (http://code.msdn.microsoft.com/PowerShellPack) and IseCream (http://psisecream.codeplex.com/),
# you can use this code to add your menu items. The added benefits are that you can specify the order of the menu items and
# if the shortcut already exists it will add the menu item without the shortcut instead of failing as the default does.
# Add-IseMenu -Name "Comments" @{            
#    "Block Comment Selected"  = {ConvertTo-BlockComment}| Add-Member NoteProperty order  1 -PassThru  | Add-Member NoteProperty ShortcutKey "Ctrl+SHIFT+B" -PassThru
#    "Block Uncomment Selected" = {ConvertTo-BlockUncomment}| Add-Member NoteProperty order  2 -PassThru  | Add-Member NoteProperty ShortcutKey "Ctrl+Alt+B" -PassThru
#    "Comment Selected" = {ConvertTo-Comment}| Add-Member NoteProperty order  3 -PassThru  | Add-Member NoteProperty ShortcutKey "Ctrl+SHIFT+C" -PassThru
#    "Uncomment Selected"  = {ConvertTo-Uncomment}| Add-Member NoteProperty order  4 -PassThru  | Add-Member NoteProperty ShortcutKey "Ctrl+Alt+C" -PassThru
#    }