From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 06:48:10 +0200
Subject: [PATCH] ARM: mxs: Let GPMI driver be built by default
In-Reply-To: <20120521041907.GC8140@S2101-09.ap.freescale.net>
References: <1337570413-31407-1-git-send-email-festevam@gmail.com>
 <20120521041907.GC8140@S2101-09.ap.freescale.net>
Message-ID: <201205210648.10838.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Mon, May 21, 2012 at 12:20:13AM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Let GPMI driver be built by default.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Queued for 3.6.  Thanks.

Heh, if we get such trivial things in so late, the imx28 will be dead platform 
by the time it's supported mainline :-)

> 
> Regards,
> Shawn
> 
> > ---
> > 
> >  arch/arm/configs/mxs_defconfig |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/configs/mxs_defconfig
> > b/arch/arm/configs/mxs_defconfig index 5406c23..6b86df7 100644
> > --- a/arch/arm/configs/mxs_defconfig
> > +++ b/arch/arm/configs/mxs_defconfig
> > @@ -58,6 +58,9 @@ CONFIG_CAN_FLEXCAN=m
> > 
> >  CONFIG_DEVTMPFS=y
> >  # CONFIG_FIRMWARE_IN_KERNEL is not set
> >  # CONFIG_BLK_DEV is not set
> > 
> > +CONFIG_MTD=y
> > +CONFIG_MTD_NAND=y
> > +CONFIG_MTD_NAND_GPMI_NAND=y
> > 
> >  CONFIG_NETDEVICES=y
> >  CONFIG_NET_ETHERNET=y
> >  CONFIG_ENC28J60=y

Best regards,
Marek Vasut
