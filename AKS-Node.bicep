
Param location string = resourcegroup().Location
Paramaksname string = 'prodAksCluster'
Param subnetId string
Param LogAnalyticworkspaceId string




Resource aks 'microsoft.Containerservice/managedClusters@2024-02-02-preview' = {
    name:aksName
    location: location
    idntity: {
        type: 'SystemAssigned'

    }
    properties: {
        dnsprefix: 'prodaksdns'
        enableRBAC: true
        kubernernetsVersion: '1.29.2'
        networkprofile: {
            networkplugin: 'azure'
            networkploicy: 'azure'
            servicecidr: '10.0.0.0/16'
            dnsserviceIp: '10.0.0.10'
            dockerbridgecidr: '175.17.0.1/16'
            outboundType: 'loadbalancer'

        }
        agentpoolprofiles: [
            {
                name: 'systempool'
                vmsize: 'standard_Ds3_v2'
                osType: 'Linux'
                mode: 'system'
                count: 3
                maxCount: 10
            }
            {
                name: 'gpubatchpool'
                vmsize: 'standard_NC6'
                osType: 'Linux'
                count: 1
                vnetsubnetId: subnetId 
                enableAutoscaling: false
            }
        ]
        addonprofiles: {
            azureMonitor: {
                enabled: true
                config: {
                    loganalyticsworkspaceresourceID: logAnalyticsWorkspaceId 
                }
            }
        }
        apiseverAccessprofile:{
            enableprivateCluster: true
        }

    }
}           
