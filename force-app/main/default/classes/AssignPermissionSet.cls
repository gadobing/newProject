global class AssignPermissionSet {
    global static void AssignPermissionSetToUser(List<user> lstUsers,string psid){		
       //this was not in there before
        for (user u:lstUsers){
            try{
            PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId=psid,AssigneeId=u.Id);
            upsert psa;                
            } catch(Exception e) {
                System.debug('An exception occured: ' + e.getMessage());
            } finally {
                System.debug('Closing the action');
            }

        }
    }	
}