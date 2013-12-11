From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Dec 2013 08:34:47 +0100
Subject: [PATCH] MAINTAINERS: merge IMX6 entry into IMX
In-Reply-To: <1386685161-12758-1-git-send-email-shawn.guo@linaro.org>
References: <20131210121626.39b3e543@ipc1.ka-ro>
 <1386685161-12758-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20131211073445.GZ24559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 10:19:21PM +0800, Shawn Guo wrote:
> I have been co-maintaining IMX sub-architecture for a couple of years,
> and collecting IMX sub-architecture patches rather than IMX6 only ones
> for a few release cycles.  It makes sense to officially add myself as
> the co-maintainer for IMX sub-architecture now.  Consequently, IMX6
> entry can just be merged into IMX.
> 
> While at it, add a 'F:' entry for IMX DTS files.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> ---
>  MAINTAINERS |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13c15c8..c0cad90 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -894,18 +894,13 @@ F:	arch/arm/mach-footbridge/
>  
>  ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
>  M:	Sascha Hauer <kernel@pengutronix.de>
> -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> -T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
> -F:	arch/arm/mach-imx/
> -F:	arch/arm/configs/imx*_defconfig
> -
> -ARM/FREESCALE IMX6
>  M:	Shawn Guo <shawn.guo@linaro.org>

Put yourself ontop since you're doing way more for i.MX than I do.
Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.linaro.org/people/shawnguo/linux-2.6.git
> -F:	arch/arm/mach-imx/*imx6*
> +F:	arch/arm/mach-imx/
> +F:	arch/arm/boot/dts/imx*
> +F:	arch/arm/configs/imx*_defconfig
>  
>  ARM/FREESCALE MXS ARM ARCHITECTURE
>  M:	Shawn Guo <shawn.guo@linaro.org>
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
