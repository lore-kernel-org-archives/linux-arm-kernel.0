From: gigin_jose@yahoo.co.in (GIGIN JOSE)
Date: Wed, 23 Nov 2011 09:01:58 +0000 (UTC)
Subject: wake up from sleep on s3c2416
Message-ID: <loom.20111123T061009-728@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am working on s3c2416 SOC with embedded linux operating system. I need to wake 
up the system from sleep mode. Will the wake up from sleep mode happen from a 
single external interrupt source ? ie, if I need to use EINT0 as my wake up 
source, will the wake up event be disabled from EINT1 or any other external 
interrupt sources ? 

How can I configure the condition to wake up before going to power down mode ? 

Thank You
