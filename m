From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 10 May 2012 14:05:24 +0800
Subject: i.MX USB Re-Structure
Message-ID: <20120510060523.GA32703@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Recently, Alexander Shishkin has posted new chipidea patchset
(http://www.spinics.net/lists/linux-usb/msg62975.html)
to support USB driver who use chipidea core. In his structure,
all controller related files (like ehci-mxc.c, fsl-udc-core.c, etc)
will be drivers/usb/chipidea, and no related file will be host, gadget
and otg again.

So, it will be different with marek has posted i.mx28 USB driver,
and also different with your proposal in the past. But I think
you and marek may prefer Alexander's structure, and would like
use it for i.mx in future, correct?

If it is, I may need to cease Freescale i.mx6q USB driver development
with your old proposal (Marek mx28 style's). Let me know your suggestion.

-- 

Best Regards,
Peter Chen
