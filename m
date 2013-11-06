From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Nov 2013 21:27:18 +0800
Subject: [PATCH v6 0/8] ARM: imx27 pinctrl
In-Reply-To: <20131106124906.GG15098@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
 <20131106124906.GG15098@pengutronix.de>
Message-ID: <20131106132633.GB4352@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 01:49:06PM +0100, Markus Pargmann wrote:
> > Markus Pargmann (8):
> >   pinctrl: imx1 core driver
> >   pinctrl: imx27: imx27 pincontrol driver
> >   ARM: dts: imx27 pin functions
> >   ARM: dts: imx27 pinctrl
> >   ARM: dts: imx27 phyCARD-S pinctrl
> >   ARM: dts: imx27 phycore move uart1 to rdk
> >   ARM: dts: imx27 phycore pinctrl
> >   ARM: imx27: enable pinctrl
> 
> Linus applied the first two patches. Could you take the others?

Oh, we just changed all IMX dts pinctrl nodes to be board specific with
series [1], which is now available on branch below.  Can you please
respin your patches to use the new approach?

  git://git.linaro.org/people/shawnguo/linux-2.6.git for-next

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/277649
