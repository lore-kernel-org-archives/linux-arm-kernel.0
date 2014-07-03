From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Jul 2014 08:31:42 +0200
Subject: [PATCH] MAINTAINERS: merge MXS entry into IMX one
In-Reply-To: <1404286630-9662-1-git-send-email-shawn.guo@freescale.com>
References: <1404286630-9662-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140703063142.GL14257@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 03:37:10PM +0800, Shawn Guo wrote:
> The mach-mxs platform is actually co-maintained by myself and
> pengutronix folks.  Also it's hosted in the same kernel tree as IMX.
> So let's merge the entry into IMX one.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  MAINTAINERS | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 134483f206e4..161762e40b85 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -943,16 +943,10 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
>  F:	arch/arm/mach-imx/
> +F:	arch/arm/mach-mxs/
>  F:	arch/arm/boot/dts/imx*
>  F:	arch/arm/configs/imx*_defconfig
>  
> -ARM/FREESCALE MXS ARM ARCHITECTURE
> -M:	Shawn Guo <shawn.guo@linaro.org>
> -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> -T:	git git://git.linaro.org/people/shawnguo/linux-2.6.git
> -F:	arch/arm/mach-mxs/
> -
>  ARM/GLOMATION GESBC9312SX MACHINE SUPPORT
>  M:	Lennert Buytenhek <kernel@wantstofly.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -- 
> 1.8.3.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
