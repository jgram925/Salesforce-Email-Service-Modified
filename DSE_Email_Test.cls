@isTest
private class Apex_Distributor_Sales_Enchancement_Test {
  
    static testmethod void dse_email(){
        // Create new email and envelope
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // Email data
        email.subject = 'In-Person Meeting with Jim';
        email.plainTextBody = 'Hey I just wanted to reach out to say, HI!';
        env.fromAddress = 'test@test.com';
        
        // Add an Text atatchment
      	Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      	attachmenttext.body = 'my attachment text'.repeat(20000);
      	attachmenttext.fileName = 'textfiletwo3.txt';
      	attachmenttext.mimeTypeSubType = 'texttwo/plain';        
      	email.textAttachments = new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
        
        // Add an Binary attachment
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text'.repeat(20000));
        attachment.fileName = 'textfileone.txt';
        attachment.mimeTypeSubType = 'text/plain';		
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };       
        
	// Call the email service class
        Apex_Distributor_Sales_Enhancement dse = new Apex_Distributor_Sales_Enhancement();
        dse.handleInboundEmail(email, env);
    }
}
