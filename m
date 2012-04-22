From: marex@denx.de (Marek Vasut)
Date: Sun, 22 Apr 2012 17:42:05 +0200
Subject: [PATCH 02/11] MXS: Add USB EHCI and USB PHY clock handling
In-Reply-To: <20120422144159.GC26306@S2101-09.ap.freescale.net>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-3-git-send-email-marex@denx.de>
 <20120422144159.GC26306@S2101-09.ap.freescale.net>
Message-ID: <201204221742.05353.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sun, Apr 22, 2012 at 02:59:18PM +0200, Marek Vasut wrote:
> > Based on code by:
> > Tony Lin <tony.lin@freescale.com>
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
> >  arch/arm/mach-mxs/clock-mx28.c |   21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> The first 2 patches in series are patching files to be removed.
> We are switching mxs clock to common clk framework.

When is this mxs clock framework scheduled to hit mainline? I obviously had to 
patch this stuff to work with mainline, once there's new framework, it should be 
easy to just change these patches.

Best regards,
Marek Vasut
