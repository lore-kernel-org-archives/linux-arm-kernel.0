From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 May 2012 14:58:34 +0200
Subject: i.MX USB Re-Structure
In-Reply-To: <20120510060523.GA32703@nchen-desktop>
References: <20120510060523.GA32703@nchen-desktop>
Message-ID: <20120510125834.GT27341@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 02:05:24PM +0800, Peter Chen wrote:
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

I was not aware of this patchset. I only had a short look at it, but
yes, it seems to be the way to go, for all SoCs supporting this
hardware, be it i.MX, MXS or something else.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
