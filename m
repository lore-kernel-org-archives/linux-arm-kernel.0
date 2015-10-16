From: B48286@freescale.com (Hou Zhiqiang)
Date: Fri, 16 Oct 2015 02:44:25 +0000
Subject: [PATCH V4 2/6] watchdog: Add support for Freescale Layerscape
 platforms
In-Reply-To: <561FB74F.5000302@roeck-us.net>
References: <1444911181-21696-1-git-send-email-B48286@freescale.com>
 <1444911181-21696-2-git-send-email-B48286@freescale.com>
 <561FB74F.5000302@roeck-us.net>
Message-ID: <CY1PR0301MB0780DF1B1E70E26836DD261A8B3D0@CY1PR0301MB0780.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Guenter Roeck [mailto:linux at roeck-us.net]
> Sent: 2015?10?15? 22:25
> To: Hou Zhiqiang-B48286; linux-arm-kernel at lists.infradead.org;
> catalin.marinas at arm.com; will.deacon at arm.com; linux-i2c at vger.kernel.org;
> linux-watchdog at vger.kernel.org; linux-doc at vger.kernel.org; linux-
> clk at vger.kernel.org
> Cc: mark.rutland at arm.com; wsa at the-dreams.de; wim at iguana.be;
> corbet at lwn.net; mturquette at baylibre.com; sboyd at codeaurora.org; Hu
> Mingkai-B21284; Xie Shaohui-B21989; Wood Scott-B07421; Sharma Bhupesh-
> B45370; Song Wenbin-B53747
> Subject: Re: [PATCH V4 2/6] watchdog: Add support for Freescale
> Layerscape platforms
> 
> On 10/15/2015 05:12 AM, Zhiqiang Hou wrote:
> > From: Shaohui Xie <Shaohui.Xie@freescale.com>
> >
> > Modify watchdog/Kconfig file to support Layerscape platforms.
> >
> > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > ---
> > This patch has been acked in V3 by Guenter Roeck [linux at roeck-us.net].
> >
> Here it is again, but if there is no change, please just add the Ack to
> subsequent versions of the patch.
> 

Ok, thanks.

> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> 
> > V4: V3 V2
> >   - No change.
> >
> >   drivers/watchdog/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> > 79e1aa1..448dbaf 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
> >
> >   config IMX2_WDT
> >   	tristate "IMX2+ Watchdog"
> > -	depends on ARCH_MXC
> > +	depends on ARCH_MXC || ARCH_LAYERSCAPE
> >   	select REGMAP_MMIO
> >   	select WATCHDOG_CORE
> >   	help
> >

Thanks,
Zhiqiang
