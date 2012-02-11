From: baruch@tkos.co.il (Baruch Siach)
Date: Sat, 11 Feb 2012 19:38:38 +0200
Subject: [PATCH] MAINTAINERS: Update ARM/FREESCALE IMX entry
In-Reply-To: <1328981091-12296-1-git-send-email-shawn.guo@linaro.org>
References: <1328981091-12296-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120211173838.GA3119@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sat, Feb 11, 2012 at 09:24:51AM -0800, Shawn Guo wrote:
> With arch/arm/mach-mx5 merged into arch/arm/mach-imx, it may be
> reasonable to make the following two changes.
> 
> * Remove 'arch/arm/mach-mx*/' from entry 'ARM/FREESCALE IMX entry',
>   since mach-mx5 has gone into mach-imx and mach-mxs already gets
>   another separate entry, which means mach-mx* only stands for mach-imx
>   anyway.
> 
> * Remove entry 'ARM/FREESCALE IMX51' completely, since mach-mx5 has
>   gone and it seems that Amit Kucheria has lost the interest in
>   maintaining IMX51 for some time.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@canonical.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> ---
>  MAINTAINERS |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1fce9a..f0946a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -785,16 +785,9 @@ M:	Sascha Hauer <kernel@pengutronix.de>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
> -F:	arch/arm/mach-mx*/
>  F:	arch/arm/mach-imx/
>  F:	arch/arm/plat-mxc/
>  
> -ARM/FREESCALE IMX51
> -M:	Amit Kucheria <amit.kucheria@canonical.com>
> -L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> -F:	arch/arm/mach-mx5/
> -

Commit 0960e7d1 (MAINTAINERS: remove iMX5 section) removed this part already.

baruch

>  ARM/FREESCALE IMX6
>  M:	Shawn Guo <shawn.guo@linaro.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -- 

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
