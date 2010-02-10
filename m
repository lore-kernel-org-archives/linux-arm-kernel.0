From: amit.walambe@eurotech.com (Amit Walambe)
Date: Wed, 10 Feb 2010 12:05:55 +0530
Subject: [PATCH] Eurotech Zeus : Making USB port 2 work
Message-ID: <20100210120555.1b648467@ironhide>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The attached patch adds support for the second USB port of
Arcom/Eurotech Zeus SBC. Currently only port 1 works. The patch sets the
power enabling GPIO for port 2 and corrects the port initialisation
flags.
Please accept.
Thanks and regards,
- Amit

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
-------------- next part --------------
A non-text attachment was scrubbed...
Name: eurotech_zeus_usb_port2.patch
Type: text/x-patch
Size: 1649 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100210/ea474a58/attachment-0001.bin>
