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

    $driver = Invoke-ChromeBrowser

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