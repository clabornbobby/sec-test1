<#
.SYNOPSIS
    Function that returns a list of Octopus events given optional paremeters.
.DESCRIPTION
    Function that returns a list of Octopus events related to an Octopus Task. This can be used
    to find events related to a deployment task, such as deployment started or ended.
    
    This function was created to be used to find deployment task start dates and compare them 
    with the current time to determine if they are long running and cancel them.

    Zick, Bryan
    09/03/2019
.PARAMETER OctopusURL
    Default value is http://octopus.autonation.com
    Parameter is used as the base url for all octopus api calls.
.PARAMETER APIKey
    Octopus api key string. This is added to the headers for all octopus api requests as X-Octopus-ApiKey. This is needed to authenticate with the octopus api.
.PARAMETER Options
    ?skip,regarding,regardingAny,user,users,projects,environments,eventGroups,eventCategories,tags,tenants,from,to,internal,fromAutoId,toAutoId,documentTypes,asCsv,take,ids
.EXAMPLE
    Get-OctopusEvents -APIKey "API-EX4MPL31K3Y"
.EXAMPLE
    #[SuppressMessage("Microsoft.Security", "CS002:SecretInNextLine", Justification="Secret Exampple")]
    Get-OctopusEvents -OctopusURL "http://octopus.autonation.com" -APIKey "API-EX4MPL31K3Y" @{"regardingAny"="ServerTasks-NNNNN"; "includeSystem" = "true"}
#>
function Get-OctopusEvents {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$APIKey,
        [string]$OctopusURL = "http://octopus.autonation.com",
        [hashtable]$Options = $null
    )
    
    process {
        $APIKey="API-EX4MPL31K3Y"
        $Header = @{ "X-Octopus-ApiKey" = $APIKey }

        $ApiURL = $OctopusURL + "/api/events"
        Invoke-RestMethod -Uri $ApiURL -Headers $Header -Body $Options -Method Get -UseBasicParsing
    }
}