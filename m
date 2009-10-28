From: Virupax.SS@Lntemsys.com (Virupax.SS at Lntemsys.com)
Date: Wed, 28 Oct 2009 20:30:59 +0530
Subject: smsc911x driver fails on ifconfig down and up
Message-ID: <OFA313B4AC.C7E2966E-ON6525765D.005208E0-6525765D.005263B5@lntemsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am using linux 2.6.27 on at91sam9g20 board.When i ping the smsc 9115 
ethernet as below on boot up it works

ping -s 65000 192.168.1.1

but if i do ifconfig down and ifconfig up for the smsc ethernet and then 
the ping to the ethernet as above down not work.

Can you please tell what problem may be there with the driver.

Thanks



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091028/ceb6de87/attachment.htm>
