 // ================================== bicep ===============================

 param location string = resourceGroup().location
 param vnetName string = 'prod-vnet'
 param subnetName string = 'prod-aks-subnet'


 resource vnet 'microsoft.Network/virtualNetworks@2023-09-01' = {
    name: vnetName
    location: location
    properties: {
        addressSpace: {
            addressPrefixes: [
                '10.1.0.0/16'
            ]
        }
        subnets:[
            {
               name: subnetName
               properties: {
                addressPrefix: '10.1.1.0/24'

               } 
            }

        ]
    }
 }

output subnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetName)
