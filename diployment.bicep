# =============== Deploy Bicep Template ===================================

# ============ Deploy Vnet and get subnet id ===========================


az deployment group create \ 
--resource-group prod-aks-rg \ 
--template-file network.bicep \
--output json \
--query properties.outputs.subnetId.value





# please copy the returned subnetId


------------------------------------------------------------------------------------



# ============ Deploy Log Analytics and Get Workspace ID ==========

az deployment group create \
--resource-group prod-aks-rg \
--template-file monitor.bicep \
--output json \
--query properties.outputs.workspaceId.value


# copy the workspaceId.


----------------------------------------------------------------------------


# ============== Deploy AKS Cluster ============

# Replace <subnetId> and <workspace> with actual valus:

az deployment group create \
--resource group prod-aks-rg \
--template-file aks-prod.bicep \
--parameters subnetId='<subnetId>' logAnaliticworkspaceId='<workspaceId>'




------------------------------------------------------------------------------------------ 



step - 4 

4: Secure Your Cluster (Best Practices)
Enable Azure AD Integration
(Can be added via Bicep or Azure CLI)

Restrict Public API Server Access
Use private cluster setup (enablePrivateCluster: true).

Set RBAC & Pod Security Policies
Use Azure RBAC and namespaces to enforce least privilege.

Enable Monitoring
Already added using azureMonitor addon in the Bicep.

Auto-Scaling & Upgrade Strategy
Enabled using enableAutoScaling. You can configure maintenance windows.





-------------------------------------------------------------


