From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Nov 2011 14:37:22 +0800
Subject: [PATCH] ARM: imx: drop 'ARCH_MX31' and 'ARCH_MX35'
In-Reply-To: <20111122090718.GD27267@pengutronix.de>
References: <1321882445.32195.3.camel@x61.thuisdomein>
 <20111121133603.GR9581@n2100.arm.linux.org.uk>
 <20111122090718.GD27267@pengutronix.de>
Message-ID: <20111124063720.GG17979@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 10:07:18AM +0100, Sascha Hauer wrote:
[...]
> Indeed, I never realized that it's missing arch/arm/mach-imx
> 
> 8<----------------------------------------
> 
> MAINTAINERS: Add missing directory
> 
> arch/arm/mach-imx/ is part of the i.MX support. Add it.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  MAINTAINERS |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 071a996..c9ae02a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -789,6 +789,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
>  F:	arch/arm/mach-mx*/
> +F:	arch/arm/mach-imx/
>  F:	arch/arm/plat-mxc/
>  
>  ARM/FREESCALE IMX51

I think as the part of the update, 'arch/arm/mach-mx*/' should be
removed, since I'm now responsible for maintaining mach-mxs, and
mach-mx5 is going into mach-imx anyway.

-- 
Regards,
Shawn
