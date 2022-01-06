trigger PaymentTrigger on Payment__c (after insert, after update, after delete, after undelete) {
    
    if(Trigger.isinsert || Trigger.isupdate){
       
        PaymentTriggerHelper.onAfterInsertAndUpdate(trigger.new);
        
    }
     if(trigger.isdelete){
       
        PaymentTriggerHelper.onAfterDelete(trigger.old);
        
    }
    if(Trigger.isinsert || Trigger.isupdate){
       
        PaymentTriggerHelper.onAfterInsertAndUpdateProj(trigger.new);
        
    }
    if(trigger.isdelete){
       
        PaymentTriggerHelper.onAfterDeleteProj(trigger.old);
        
    }
}