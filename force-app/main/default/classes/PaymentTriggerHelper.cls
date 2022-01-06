public class PaymentTriggerHelper {
    // Calculate total amount and recent date on contct object.
    public static void onAfterInsertAndUpdate (List<Payment__c> newPayment){
       // create a set to store contact ids.
        set<id> contids= new set<id>();
        for(Payment__c Pmt:newPayment){
            //Store contact Ids into the contids.
            contids.add(Pmt.Contact__c);
        }     
        List<Contact> cont = [Select id, Recent_Payment_Date__c,Total_Amount_Of_Payment__c,
                              (Select id,Amount__c,Payment_Date__c from Payments__r ORDER BY Payment_Date__c ASC) from Contact where id IN: contids];
        if(cont!=null){
            for(Contact contValue:cont){
                Decimal sum=0;
                Date PayDate;
                for(Payment__c pay:contValue.Payments__r ){
                    sum = sum+pay.Amount__c;
                    PayDate = pay.Payment_Date__c;
                }   
                contValue.Total_Amount_Of_Payment__c = sum;
                contValue.Recent_Payment_Date__c = PayDate;
                
            } 
        }
        if(!cont.isempty()){
            update cont;
        }
    }
    public static void onAfterDelete (List<Payment__c> oldPayment){
        
        set<id> contids= new set<id>();
        for(Payment__c Pmt:oldPayment){
            contids.add(Pmt.Contact__c);
        }     
        List<Contact> cont = [Select id, Recent_Payment_Date__c,Total_Amount_Of_Payment__c,
                              (Select id,Amount__c,Payment_Date__c from Payments__r ORDER BY Payment_Date__c ASC) from Contact where id IN: contids];
        if(cont!=null){
            for(Contact contValue:cont){
                Decimal sum=0;
                for(Payment__c pay:contValue.Payments__r ){
                    sum = sum+pay.Amount__c;
                }   
                contValue.Total_Amount_Of_Payment__c = sum;
            } 
        }
        if(!cont.isempty()){
            update cont;
        }
    }
    //Calculate the total amount on Project object.
    public static void onAfterInsertAndUpdateProj (List<Payment__c> newPayment){
        set<id> projids= new set<id>();
        for(Payment__c Pmt:newPayment){
            projids.add(Pmt.Project__c);
        }     
        List<Project__c> proj = [Select id, Total_Amount_Of_Payment__c,(Select id,Amount__c from Payments__r ORDER BY Payment_Date__c ASC) 
                                 from Project__c where id IN: projids];
        if(proj!=null){
            for(Project__c projValue:proj){
                Decimal sum=0;
                for(Payment__c pay:projValue.Payments__r ){
                    sum = sum+pay.Amount__c;
                    
                }   
                projValue.Total_Amount_Of_Payment__c = sum;  
            } 
        }
        if(!proj.isempty()){
            update proj;
        }
    }
    public static void onAfterDeleteProj(List<Payment__c> oldPayment){
        set<id> projids= new set<id>();
        for(Payment__c Pmt:oldPayment){
            projids.add(Pmt.Project__c);
        }     
        List<Project__c> proj = [Select id, Total_Amount_Of_Payment__c,(Select id,Amount__c from Payments__r ORDER BY Payment_Date__c ASC) 
                                 from Project__c where id IN: projids];
        if(proj!=null){
            for(Project__c projValue:proj){
                Decimal sum=0;
                for(Payment__c pay:projValue.Payments__r ){
                    sum = sum+pay.Amount__c;
                    
                }   
                projValue.Total_Amount_Of_Payment__c = sum;  
            } 
        }
        if(!proj.isempty()){
            update proj;
        }
    }
}