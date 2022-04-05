trigger CSRAgentTrigger on User (after insert) {
    
    //Filter this specifically for a CSR Agent
    profile pid = [SELECT Id FROM profile WHERE Name LIKE 'CSR Agent'];
	String CSRagentProfileID = pid.Id; 

    permissionset hcsps = [SELECT Id FROM permissionset WHERE Name like 'HealthCloudStandard'];
    permissionset hcmsps = [SELECT Id FROM permissionset WHERE Name LIKE 'HealthCloudMemberServices'];
    permissionset hcpslps = [SELECT Id FROM permissionset WHERE Name LIKE 'HealthCloudPermissionSetLicense'];
    
    String hcs = hcsps.Id;
	String hcms = hcmsps.Id;    
    string hcpsl = hcpslps.Id;    

    List<User> lstUser = new List<user>();    
    for(user c :trigger.new){
        string userProfileID = c.ProfileId;
        
        system.debug('userprofileid: ' + userProfileID);
        system.debug('csrProfileID: ' + CSRagentProfileID);
        
        if(userProfileID == CSRagentProfileID){
    		user u = [SELECT ID from User WHERE id = :c.Id];
            lstUser.add(u);                    
    	}
    }
    if(!lstUser.isEmpty()){
    	AssignPermissionSet.AssignPermissionSetToUser(lstUser,hcs);
    	AssignPermissionSet.AssignPermissionSetToUser(lstUser, hcms);
        AssignPermissionSet.AssignPermissionSetToUser(lstUser, hcpsl);
        }
}