/********************************
 * Developed By: Joshua Ramczyk *
 * Date Developed: 12/21/2021   *
 ********************************/

global class Apex_Distributor_Sales_Enhancement implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.Inboundenvelope envelope){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();     
        
        // Declare Variables
        String acctId = '0013J00000KUZXZ';
        Distributor_Sales_Enhancement__c dse;

        try{
            // Create Distributor Sales Enhancement Record
            dse = new Distributor_Sales_Enhancement__c();
            dse.DSE_Account_del__c = acctId;
            dse.Author_del__c = email.fromName;
            dse.Subject__c = email.subject;
            dse.Message__c = email.plainTextBody;
            insert dse;
            
            // Checks for Attachments and Inserts them, and Checks dse Attachments box
            List<Attachment> attachments = new List<Attachment>();
            if(email.textAttachments != null){
                for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments){
                    System.debug(tAttachment.body.length());
                    if(tAttachment.body.length() > 10240){
                    	Attachment attachment = new Attachment();
                        attachment.Name = tAttachment.fileName;
                        attachment.Body = Blob.valueOf(tAttachment.body);
                        attachment.ParentId = dse.Id;
                        attachments.add(attachment);    
                    }                                        
                }
            }
            if(email.binaryAttachments != null){
                for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments){
                    System.debug(bAttachment.body.size());
                    if(bAttachment.body.size() > 10240){
                        Attachment attachment = new Attachment();
                        attachment.Name = bAttachment.fileName;
                        attachment.Body = bAttachment.body;
                        attachment.ParentId = dse.Id;                    
                        attachments.add(attachment);                        
                    }
                }
            }
            if(attachments.size() > 0){                
                insert attachments;
                dse = [SELECT Id FROM Distributor_Sales_Enhancement__c ORDER BY Name desc LIMIT 1];
                System.debug(dse.Id);
                dse.Attachments__c = TRUE;
                upsert dse;
            }            
            
           	// Results
            result.success = true;
        }catch(Exception e){
            result.success = false;
            result.message = e.getMessage() + e.getStackTraceString();
        }
        return result;
	}
}
