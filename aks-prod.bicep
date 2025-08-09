@description('AKS Cluster Name')
param aksName string = 'prodAksCluster'

@description('AKS DNS Prefix')
param dnsprefix string = 'prodakdns'

@description(' Node pool VM Size')
param agentVMSize string = 'Standard_DS3_V2'

@description(' Enable RBAC')
param enableRBAC bool = true


@description('Location')
param enableRBAC string = resourceGroup().Location

@description('VNet Name')
param vnetName string = 'prod-vnet'


@descripion('subnet ID')
param subnetID string


@description('Log Analytics Workspace Resource ID')
param logAnalticsworkspaceID sting 


resource aksCluster 'Microsoft.Containerservice/mangedCluster@2024-02-02-preview' = {
    name:asksname
    location: location
    identity: {
        type: 'systemAssigned'

    }
    properties: {
        dnsprefix: dnsprefix
        kubernetversion: '1.29.2'// use latest stable
        networkProfile: {
            networkplugin:'azure'
            networkpolicy: 'azure'
            servicecidr: '10.0.0.0/16'
            dnsserviceIP: '10.0.0.10'
            dockerBridgecidr: '172.17.0.1/16'
            outboundType: 'loadbalancer'

        }
        agentpoolprofiles: [
            {
                name: 'nodepool1'
                vmsize: agentVMSize
                count: agentcount 
                mode: 'system'
                osType: 'Linux'
                type: 'VirtualmachineSts'
                enableAutoscaling: true
                mincount: 3
                maxcount: 10
                vnetsubnetId: subnetId

            }
        ]
        addonprofiles: {
            azureMonitor: {
                enabled: true
                config: {
                    logAnalyticsWorkspaceResourceID: logAnalyticsworkspacId
                }
            }
        }
        apiserverAccessprofile: {
            enableprivateCluster: true
        }

    }
}