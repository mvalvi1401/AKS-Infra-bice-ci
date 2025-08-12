# =================== AKS with azure AD integration ====================

# this is important when using azure AD group for kubernetes enableRBAC




 param location string = resourceGroup().location
 param aksname string 
 param subnetId string 
 param logAnalyticsWorkspaceIDs array




 resource aks 'microsoft.Containerservice/managedCluster@2024-01-02-preview' = {
    name: aksName
    location: location 
    identity: {
        type: 'SystemAssigned'

    }
    properties: {
        dnsprefix: 'prodaksdns'
        enableRBAC: true 
        aadprofile: {
            managed: true 
            adminGroupobjectIDs: adminGroupobjectIDs 
            enableAzureRBAC: true 
        }
        agentpoolprofile: [
            {
                name: 'systempool'
                vmsize: 'standard_DS3_V2 
                count: 3
                vnetsubnetId: subnetId
                mode: 'system'
                enableAutoscaling: true
                mincount: 3
                maxcount: 10
            }
        ]
        addonprofiles: {
            azureMonitor: {
                enabled: true
                config: {
                    logAnalyticsWorkspacesourceID: logAnalyticsspaceId 
                }
            }
        }
        apiserveraccessprofile: {
            enableprivateCluster: true
        }
    }
 }