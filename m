From: marex@denx.de (Marek Vasut)
Date: Sun, 22 Apr 2012 17:42:53 +0200
Subject: [PATCH 04/11] MXS: Add data shared between imx-otg and EHCI driver
In-Reply-To: <20120422143938.GB26306@S2101-09.ap.freescale.net>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-5-git-send-email-marex@denx.de>
 <20120422143938.GB26306@S2101-09.ap.freescale.net>
Message-ID: <201204221742.53825.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sun, Apr 22, 2012 at 02:59:20PM +0200, Marek Vasut wrote:
> > This patch adds common data shared between the MXS EHCI HCD driver,
> > the MXS USB Gadget driver and the imx-otg driver. These data allow
> > passing clock and memory stuff from imx-otg driver into the
> > host/gadget driver.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Chen Peter-B29397 <B29397@freescale.com>
> > Cc: Detlev Zundel <dzu@denx.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Li Frank-B20596 <B20596@freescale.com>
> > Cc: Lin Tony-B19295 <B19295@freescale.com>
> > Cc: Linux USB <linux-usb@vger.kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > Cc: Subodh Nijsure <snijsure@grid-net.com>
> > Cc: Tony Lin <tony.lin@freescale.com>
> > Cc: Wolfgang Denk <wd@denx.de>
> > ---
> > 
> >  include/linux/fsl/mxs-usb.h |   46
> >  +++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 46
> >  insertions(+)
> >  create mode 100644 include/linux/fsl/mxs-usb.h
> 
> As what Wolfram and Arnd pointed out in thread [1], include/linux/fsl
> is not a good choice. Instead, it should be include/linux/usb/mxs-usb.h.

Ok, noted. Will add in V5. What about the rest of these patches, I'd be 
interested to hear your opinion on these :-)

> 
> Regards,
> Shawn
> 
> [1] http://thread.gmane.org/gmane.linux.kernel/1271153/focus=163132

Best regards,
Marek Vasut
