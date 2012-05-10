From: marex@denx.de (Marek Vasut)
Date: Thu, 10 May 2012 15:12:26 +0200
Subject: i.MX USB Re-Structure
In-Reply-To: <20120510125834.GT27341@pengutronix.de>
References: <20120510060523.GA32703@nchen-desktop>
 <20120510125834.GT27341@pengutronix.de>
Message-ID: <201205101512.27073.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

> On Thu, May 10, 2012 at 02:05:24PM +0800, Peter Chen wrote:
> > Hi Sascha,
> > 
> > Recently, Alexander Shishkin has posted new chipidea patchset
> > (http://www.spinics.net/lists/linux-usb/msg62975.html)
> > to support USB driver who use chipidea core. In his structure,
> > all controller related files (like ehci-mxc.c, fsl-udc-core.c, etc)
> > will be drivers/usb/chipidea, and no related file will be host, gadget
> > and otg again.
> > 
> > So, it will be different with marek has posted i.mx28 USB driver,
> > and also different with your proposal in the past. But I think
> > you and marek may prefer Alexander's structure, and would like
> > use it for i.mx in future, correct?
> 
> I was not aware of this patchset. I only had a short look at it, but
> yes, it seems to be the way to go, for all SoCs supporting this
> hardware, be it i.MX, MXS or something else.

Correct, I can't but agree here.

> Sascha

Best regards,
Marek Vasut
