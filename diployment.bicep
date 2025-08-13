// =============== Deploy Bicep Template ===================================

// ============ Deploy Vnet and get subnet id ===========================


// TODO: Remove shell commands. Only Bicep resource definitions should be here.





// please copy the returned subnetId






//============ Deploy Log Analytics and Get Workspace ID ==========

// TODO: Define Log Analytics Workspace as a Bicep resource here.




// ============== Deploy AKS Cluster ============

// Replace <subnetId> and <workspace> with actual valus:

// Parameters for subnetId and workspaceId
param subnetId string
param workspaceId string

// TODO: Define Log Analytics Workspace as a Bicep resource above and reference its id here if needed

// AKS Cluster resource definition
resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-01-01' = {
  name: 'prod-aks-cluster'
  location: resourceGroup().location
  properties: {
    dnsPrefix: 'prod-aks'
    agentPoolProfiles: [
      {
        name: 'nodepool1'
        count: 3
        vmSize: 'Standard_DS2_v2'
        maxPods: 110
        osType: 'Linux'
        type: 'VirtualMachineScaleSets'
        mode: 'System'
        vnetSubnetID: subnetId
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      networkPolicy: 'azure'
      dnsServiceIP: '10.2.0.10'
      serviceCidr: '10.2.0.0/24'
      dockerBridgeCidr: '172.17.0.1/16'
    }
    addonProfiles: {
      omsagent: {
        enabled: true
        config: {
          logAnalyticsWorkspaceResourceID: workspaceId
        }
      }
    }
    enableRBAC: true
  }
}

// Secure Your Cluster (Best Practices)
// Enable Azure AD Integration
// (Can be added via Bicep or Azure CLI)

// Restrict Public API Server Access
// Use private cluster setup (enablePrivateCluster: true).

// Set RBAC & Pod Security Policies
// Use Azure RBAC and namespaces to enforce least privilege.

// Enable Monitoring
// Already added using azureMonitor addon in the Bicep.

// Auto-Scaling & Upgrade Strategy
// Enabled using enableAutoScaling. You can configure maintenance windows.








