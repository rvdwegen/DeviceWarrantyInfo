using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

$manufacturer = $Request.Query.manufacturer
$serialNumber = $Request.Query.serialNumber

$StatusCode = [HttpStatusCode]::OK

try {
    Connect-AzAccount -Identity
} catch {
    throw $_.Exception.Message
}

try {
ls
    function Invoke-ChromeBrowser2 {
        #$WebDriverPath = ".\resources"
        $WebDriverPath = "C:\home\site\wwwroot\resources"
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

    $driver = Invoke-ChromeBrowser2

    if (!$manufacturer) {
        throw "No manufacturer select, valid manufacturers are..."
    }

    if (!$serialNumber) {
        throw "No serial number"
    }


    $result = [pscustomobject]@{
        manufacturer = $manufacturer
        serialnumber = $serialNumber
    }


} catch {
    throw $_.Exception.Message
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $StatusCode
    Body       = $result
})