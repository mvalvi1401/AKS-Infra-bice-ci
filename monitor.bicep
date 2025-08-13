// ========================= Log Analytics Workspace Bicep =====================


param location string = resourceGroup().location
param workspaceName string = 'loganalytics-prod'



resource workspace 'Microsoft.operationInsights/workspaces@2023-10-01' = {
    name: workspaceName
    location: location
    properties: {
        retentionInDays: 30
    }
}

output workspaceId string = workspace.id
