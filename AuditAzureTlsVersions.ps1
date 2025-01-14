<#
.SYNOPSIS
    Searches Azure resources for any TLS version configuration across multiple properties.

.DESCRIPTION
    This script executes an Azure Resource Graph query that searches for resources where any
    of the following properties have a value:
      - properties.minimumTlsVersion
      - properties.MinTlsVersion
      - properties.minimalTlsVersion
    The query uses the coalesce() function to pick the first non-empty value and displays the 
    resource's name, type, and the detected TLS version. You can also export the results to a CSV file.

.PARAMETER ExportCsv
    (Optional) Provide the full path to a CSV file where you would like to export the results.
    If not specified, the results are displayed in the console.

.EXAMPLE
    .\AuditAzureTlsVersions.ps1.ps1
    Searches for resources with any TLS version value across the specified properties and displays the results.

.EXAMPLE
    .\AuditAzureTlsVersions.ps1.ps1 -ExportCsv "PATHTOFILE"
    Searches for resources with TLS version values and exports the results to the specified CSV file.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$ExportCsv,

    [Parameter(Mandatory = $false)]
    [string]$Subscriptions
)

# Authenticate to Azure
Write-Output "Authenticating to Azure..."
Connect-AzAccount

# If specific subscriptions are provided, split them into an array.
if ($Subscriptions) {
    $subscriptionArray = $Subscriptions -split ',' | ForEach-Object { $_.Trim() }
    Write-Output "Using the following subscriptions: $subscriptionArray"
}
else {
    # If no subscriptions specified, query across all available subscriptions.
    $subscriptionArray = (Get-AzSubscription).Id
    Write-Output "No specific subscriptions specified. Querying all accessible subscriptions."
}

# Build the Kusto query string.
# Explanation:
#   - The 'extend' operator uses coalesce() to check for values in multiple potential TLS properties.
#   - coalesce( tostring(properties.minimumTlsVersion), tostring(properties.MinTlsVersion), tostring(properties.minimalTlsVersion) )
#     returns the first non-null and non-empty value among the three properties.
#   - isnotempty() filters to resources with a non-empty TLS version.
$query = @"
Resources
| extend TlsVersion = coalesce(tostring(properties.minimumTlsVersion), tostring(properties.MinTlsVersion), tostring(properties.minimalTlsVersion))
| where isnotempty(TlsVersion)
| project subscriptionId, name, type, TlsVersion
"@

Write-Output "Executing Azure Resource Graph query to locate resources with TLS configuration across multiple property names..."
$results = Search-AzGraph -Query $query -Subscription $subscriptionArray

if ($null -eq $results -or $results.Count -eq 0) {
    Write-Output "No resources with TLS configuration were found using the specified properties."
    exit
}

# Display or export the results
if ($ExportCsv) {
    try {
        $results | Export-Csv -Path $ExportCsv -NoTypeInformation -Force
        Write-Output "Results exported successfully to: $ExportCsv"
    }
    catch {
        Write-Error "Failed to export CSV: $_"
    }
}
else {
    Write-Output "Displaying results:"
    $results | Format-Table -AutoSize
}