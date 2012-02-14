From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Feb 2012 11:59:56 +0100
Subject: [PATCH] MAINTAINERS: remove arch/arm/mach-mx*/ from IMX entry
In-Reply-To: <1329142226-2685-1-git-send-email-shawn.guo@linaro.org>
References: <1329142226-2685-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120214105956.GT3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 06:10:26AM -0800, Shawn Guo wrote:
> With commit 784a90c0a7d8f5 ("ARM i.MX: Merge i.MX5 support into
> mach-imx") merging mach-mx5 into mach-imx, arch/arm/mach-mx* only
> covers mach-mxs now.  Since we already have a separate MXS entry
> for arch/arm/mach-mxs, arch/arm/mach-mx* can simply be removed there.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> ---
>  MAINTAINERS |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55ca0be..37169f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -785,7 +785,6 @@ M:	Sascha Hauer <kernel@pengutronix.de>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
> -F:	arch/arm/mach-mx*/
>  F:	arch/arm/mach-imx/
>  F:	arch/arm/plat-mxc/
>  
> -- 
> 1.7.5.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
