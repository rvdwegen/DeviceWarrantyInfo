function Invoke-ChromeBrowser {
    $WebDriverPath = ".\resources"
    $ChromeService = [OpenQA.Selenium.Chrome.ChromeDriverService]::CreateDefaultService($WebDriverPath, 'chromedriver.exe')
    $ChromeService.HideCommandPromptWindow = $true
    $chromeOptions = [OpenQA.Selenium.Chrome.ChromeOptions]::new()
    $Headless = $false
    if($Headless -eq $true){
        $chromeOptions.AddArgument("headless")
    }
    $chromeOptions.AddArgument("--log-level=3")
    $driver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeService, $chromeOptions)

    return $driver
}

Export-ModuleMember -Function @('Invoke-ChromeBrowser')