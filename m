From: marex@denx.de (Marek Vasut)
Date: Thu, 10 May 2012 12:28:55 +0200
Subject: i.MX USB Re-Structure
In-Reply-To: <20120510060523.GA32703@nchen-desktop>
References: <20120510060523.GA32703@nchen-desktop>
Message-ID: <201205101228.55954.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> Hi Sascha,
> 
> Recently, Alexander Shishkin has posted new chipidea patchset
> (http://www.spinics.net/lists/linux-usb/msg62975.html)
> to support USB driver who use chipidea core. In his structure,
> all controller related files (like ehci-mxc.c, fsl-udc-core.c, etc)
> will be drivers/usb/chipidea, and no related file will be host, gadget
> and otg again.
> 
> So, it will be different with marek has posted i.mx28 USB driver,
> and also different with your proposal in the past. But I think
> you and marek may prefer Alexander's structure, and would like
> use it for i.mx in future, correct?

I noticed the patchset, I don't mind doing another round of rework. The patches 
look very good actually, very helpful for our purpose too.

> If it is, I may need to cease Freescale i.mx6q USB driver development
> with your old proposal (Marek mx28 style's). Let me know your suggestion.

SHA's adding mx6q support to my patches?

Best regards,
Marek Vasut
