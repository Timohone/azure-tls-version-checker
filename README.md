# Azure TLS Version Checker

This repository contains a PowerShell script that uses Azure Resource Graph to find Azure resources that have a TLS version configured. It searches for TLS-related properties across multiple property names and returns the resource name, type, and the TLS version value.

## Features

- **Multi-Property Search:**  
  The script checks for TLS version values across the following properties:
  - `properties.minimumTlsVersion`
  - `properties.MinTlsVersion`
  - `properties.minimalTlsVersion`

- **Flexible Output:**  
  The results are displayed in the console in a formatted table, with the option to export to a CSV file.

- **Azure Resource Graph:**  
  Utilizes the Azure Resource Graph to perform the query across all resources in your subscription.

## Prerequisites

- [Azure PowerShell module (Az)](https://learn.microsoft.com/en-us/powershell/azure/install-az-ps)
- An active Azure subscription.
- PowerShell 5.x or PowerShell Core (pwsh).

## Setup and Usage

1. **Clone the Repository**

   ```bash
   git clone https://github.com/<your-username>/azure-tls-version-checker.git
   cd azure-tls-version-checker
   ```

2. **Authentication**
Open a PowerShell terminal and authenticate to your Azure account:
```bash
Connect-AzAccount
```

3. **Run the Script**
To display the results on the console:
```bash
.\AuditAzureTlsVersions.ps1
```
To export the results to a CSV file:
```bash
.\AuditAzureTlsVersions.ps1 -ExportCsv "PATHTOFILE"
```
