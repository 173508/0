@echo off
:: ----------------------------------------------------------
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: ----------------------------------------------------------
:: --------------Remove "Mail and Calendar" app--------------
:: ----------------------------------------------------------
echo --- Remove "Mail and Calendar" app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'microsoft.windowscommunicationsapps' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -------------------MSPaint-------------------
:: ----------------------------------------------------------
echo --- MSPaint app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.MSPaint' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -------------------WebMediaExtensions-------------------
:: ----------------------------------------------------------
echo --- WebMediaExtensions app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.WebMediaExtensions' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -------------------WebpImageExtension-------------------
:: ----------------------------------------------------------
echo --- WebpImageExtension app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.WebpImageExtension' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -------------------Microsoft.BingWeather-------------------
:: ----------------------------------------------------------
echo --- BingWeather app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.BingWeather' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -------------------Microsoft.Getstarted-------------------
:: ----------------------------------------------------------
echo --- Getstarted app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.Getstarted' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ---------------------Microsoft3DViewer--------------------
:: ----------------------------------------------------------
echo --- Microsoft3DViewer app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.Microsoft3DViewer' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: --------------MicrosoftSolitaireCollection----------------
:: ----------------------------------------------------------
echo --- MicrosoftSolitaireCollection app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.MicrosoftSolitaireCollection' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ------------------MicrosoftStickyNotes--------------------
:: ----------------------------------------------------------
echo --- MicrosoftStickyNotes app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.MicrosoftStickyNotes' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -----------------------MixedReality-----------------------
:: ----------------------------------------------------------
echo --- MixedReality app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.MixedReality.Portal' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: --------------------ScreenSketch--------------------------
:: ----------------------------------------------------------
echo --- ScreenSketch app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.ScreenSketch' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -------------------------OneNote--------------------------
:: ----------------------------------------------------------
echo --- OneNote app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.Office.OneNote' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -------------------WindowsCalculator----------------------
:: ----------------------------------------------------------
echo --- WindowsCalculator app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.WindowsCalculator' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -------------------WindowsFeedbackHub---------------------
:: ----------------------------------------------------------
echo --- WindowsFeedbackHub app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.WindowsFeedbackHub' | Remove-AppxPackage"
 
:: ----------------------------------------------------------
:: ------------------------ZuneMusic-------------------------
:: ----------------------------------------------------------
echo --- ZuneMusic app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.ZuneMusic' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ------------------------ZuneVideo-------------------------
:: ----------------------------------------------------------
echo --- ZuneVideo app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.ZuneVideo' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ----------------------------SkypeApp----------------------
:: ----------------------------------------------------------
echo --- SkypeApp app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.SkypeApp' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: --------------------WindowsSoundRecorder------------------
:: ----------------------------------------------------------
echo --- WindowsSoundRecorder app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.WindowsSoundRecorder' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ---------------------YourPhone Portal---------------------
:: ----------------------------------------------------------
echo --- YourPhone app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.YourPhone' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: --------------------------XBOX----------------------------
:: ----------------------------------------------------------
echo --- XBox app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.Xbox*' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -----------------------WindowsMaps------------------------
:: ----------------------------------------------------------
echo --- WindowsMaps app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.WindowsMaps' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ----------------------People------------------------------
:: ----------------------------------------------------------
echo --- People app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.People' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ------------------------GetHelp---------------------------
:: ----------------------------------------------------------
echo --- GetHelp app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.GetHelp' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ------------------------Photos---------------------------
:: ----------------------------------------------------------
echo --- Photos app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.Windows.Photos' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ------------------------Alarms----------------------------
:: ----------------------------------------------------------
echo --- Alarms app
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.WindowsAlarms' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ------------------------AI---------------------------
:: ----------------------------------------------------------
echo --- Microsoft.Windows.Ai
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.Windows.Ai.*' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ------------------------Get Started-----------------------
:: ----------------------------------------------------------
echo --- Microsoft.Getstarted
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.Getstarted' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: -----------------------NotepadPlusPlus--------------------
:: ----------------------------------------------------------
echo --- NotepadPlusPlus
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'NotepadPlusPlus' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ---------------------PowerAutomateDesktop-----------------
:: ----------------------------------------------------------
echo --- Microsoft.PowerAutomateDesktop
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage 'Microsoft.PowerAutomateDesktop' | Remove-AppxPackage"

:: ----------------------------------------------------------
:: ------------------Web Experience pack---------------------
:: ----------------------------------------------------------
echo --- Web Experience pack
PowerShell -ExecutionPolicy Unrestricted -Command "winget uninstall 'Windows Web Experience Pack'"

pause
exit /b 0
