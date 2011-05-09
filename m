From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 9 May 2011 14:23:25 +0800
Subject: [PATCH v2 7/7] ARM: mxc: remove esdhc.h and use the public one
In-Reply-To: <20110506083959.GS11574@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-8-git-send-email-shawn.guo@linaro.org>
	<20110506083959.GS11574@pengutronix.de>
Message-ID: <20110509062324.GA2577@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Fri, May 06, 2011 at 10:39:59AM +0200, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Thu, May 05, 2011 at 09:22:58PM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |    1 -
> >  arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +-
> what about removing arch/arm/plat-mxc/include/mach/esdhc.h in this
> patch as advertised in the subject?
> 
Yes, will do if the patch #4 will finally stands.  People are voting
for it.  Let's see Wolfram's position.

-- 
Regards,
Shawn
