From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 17:02:14 +0100
Subject: [PATCH] MAINTAINERS: ARM Versatile Express platform,
 add missing pattern
In-Reply-To: <1417443393-16704-1-git-send-email-pawel.moll@arm.com>
References: <1417442259.4058.5.camel@arm.com>
 <1417443393-16704-1-git-send-email-pawel.moll@arm.com>
Message-ID: <3271324.hJMe55l8NY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 14:16:33 Pawel Moll wrote:
> VE's reset driver lives at the third level of the directories:
> 
> 	drivers/power/reset/vexpress-poweroff.c
> 
> and wasn't matched by the */*/vexpress* pattern.
> 
> Added additional pattern for all files at this level. This should be
> enough for a while...
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 924454f..4a00598 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1512,6 +1512,7 @@ S:	Maintained
>  F:	arch/arm/boot/dts/vexpress*
>  F:	arch/arm/mach-vexpress/
>  F:	*/*/vexpress*
> +F:	*/*/*/vexpress*
>  F:	drivers/clk/versatile/clk-vexpress-osc.c
>  F:	drivers/clocksource/versatile.c

Applied to next/fixes-non-critical, thanks!

	Arnd
