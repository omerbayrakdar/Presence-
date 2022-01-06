public class GetContactData {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [Select id, FirstName, LastName,Recent_Payment_Date__c,Total_Amount_Of_Payment__c,
                              (Select id,Amount__c,Payment_Date__c from Payments__r ORDER BY Payment_Date__c ASC) from Contact where Total_Amount_Of_Payment__c!=null];
    }
}