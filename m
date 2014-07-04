From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 4 Jul 2014 09:54:53 +0800
Subject: [PATCH] ARM: imx: imx6sx uses imx6q cpuidle code
In-Reply-To: <20140703175702.GV14781@pengutronix.de>
References: <6439884.YMH7C85FhG@wuerfel>
 <20140703175702.GV14781@pengutronix.de>
Message-ID: <20140704015452.GH30239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 07:57:02PM +0200, Uwe Kleine-K?nig wrote:
> Hello Arnd,
> 
> On Thu, Jul 03, 2014 at 04:16:06PM +0200, Arnd Bergmann wrote:
> >  obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
> >  obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
> >  obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
> > +obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6q.o
> as this line looks wrong it might be worth a comment ...

Okay, I fixed it up as below.

# i.MX6SX reuses i.MX6Q cpuidle driver
obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6q.o

Shawn
