From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 31 Dec 2010 10:12:52 +0800
Subject: [PATCH v2 2/2] ARM i.MX53: Make MX53 EVK bootable
In-Reply-To: <20101230095142.GV14221@pengutronix.de>
References: <1293686881-15046-1-git-send-email-yong.shen@freescale.com>
	<1293686881-15046-3-git-send-email-yong.shen@freescale.com>
	<20101230095142.GV14221@pengutronix.de>
Message-ID: <20101231021251.GH28246@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 30, 2010 at 10:51:42AM +0100, Uwe Kleine-K?nig wrote:
> Hello Yong,
> 
> On Thu, Dec 30, 2010 at 01:28:01PM +0800, yong.shen at freescale.com wrote:
> > From: Yong Shen <yong.shen@linaro.org>
[...]
> > diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> > index 86781f7..8f11cfa 100644
> > --- a/arch/arm/plat-mxc/include/mach/irqs.h
> > +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> > @@ -29,8 +29,10 @@
> >  #define MXC_GPIO_IRQS                (32 * 4)
> >  #elif defined CONFIG_ARCH_MX25
> >  #define MXC_GPIO_IRQS                (32 * 4)
> > -#elif defined CONFIG_ARCH_MX5
> > +#elif defined CONFIG_ARCH_MX51
> >  #define MXC_GPIO_IRQS                (32 * 4)
> > +#elif defined CONFIG_ARCH_MX53
> > +#define MXC_GPIO_IRQS                (32 * 7)
> You didn't read the comment before this block.
> 
I did not read the comment either when I was trying to add mxs
support into imx-single-zimage. But the error during the run-time
forced me to go back and read the comment :)

-- 
Regards,
Shawn
