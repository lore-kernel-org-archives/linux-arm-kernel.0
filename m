From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 6 Aug 2012 16:23:45 +0200
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <20120803122516.GA23791@S2101-09.ap.freescale.net>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120803122516.GA23791@S2101-09.ap.freescale.net>
Message-ID: <20120806142345.GB9329@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Aug 03, 2012 at 08:25:18PM +0800, Shawn Guo wrote:
> On Thu, Aug 02, 2012 at 05:39:02PM +0200, Uwe Kleine-K?nig wrote:
> > +enum imx35_pads {
> > +	/* sed -r -n 's@^#define MX35_PAD_([0-9A-Z_]*)__([0-9A-Z_]*)\s+IOMUX_PAD\(\s*([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9a-fx]*),\s+([0-9]*),\s*NO_PAD_CTRL\)@\tMX35_PAD_\1, at p' arch/arm/plat-mxc/include/mach/iomux-mx35.h | uniq */
> 
> I'm not sure we want to keep a reference to
> arch/arm/plat-mxc/include/mach/iomux-mx35.h that is to be removed.
ok for me to remove it. Will resend without that line and Stephen's Ack.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
