# Azure TLS Version Report Script

## Overview

This PowerShell script generates a report on the configured TLS versions of various Azure services across all subscriptions and resource groups in a tenant. It automates the process by iterating through all subscriptions and resource groups, requiring no manual input.

The script outputs two reports:
- **CSV**: A detailed table of TLS configurations.
- **HTML**: A formatted HTML file with easy-to-read color-coded TLS compliance information.

## Supported Azure Services

The script collects TLS configuration data for the following Azure services:

- Azure App Service
- Azure Storage Accounts
- Azure SQL Database
- Azure Key Vault
- Azure Application Gateway
- Azure Front Door
- Azure API Management
- Azure Load Balancer
- Azure Virtual Network Gateway
- Azure SignalR Service
- Azure Redis Cache
- Azure Service Bus
- Azure Kubernetes Service

## Features

- **Automated Iteration:** Automatically iterates through all subscriptions and resource groups in the tenant.
- **Comprehensive Reports:** Provides CSV and HTML reports for easy analysis and sharing.
- **TLS Compliance Checking:** Highlights resources using insecure TLS versions (e.g., TLS 1.0, 1.1).
- **Error Handling:** Gracefully handles missing data and inaccessible resources.

## Requirements

- **PowerShell**: PowerShell 5.1 or later (PowerShell Core is recommended for cross-platform support).
- **Azure PowerShell Module**: Ensure the `Az` module is installed and up to date.
  ```powershell
  Install-Module -Name Az -AllowClobber -Scope CurrentUser
  ```
## Usage
### Clone this repository:

```bash
git clone <repository-url>
cd <repository-directory>
```

### Run the script:

```powershell
./AuditAzureTlsVersions.ps1
```

### Locate the output reports in the current directory:

```
AzureTLSReport.csv
AzureTLSReport.html
```

### Author
Timo Haldi