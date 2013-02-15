From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Feb 2013 15:05:35 +0530
Subject: [PATCH] ARM: OMAP2+: Remove duplicate omap4430_init_late()
 declaration
In-Reply-To: <1360336306-18277-2-git-send-email-santosh.shilimkar@ti.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
 <1360336306-18277-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <511E0167.8020700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Friday 08 February 2013 08:41 PM, Santosh Shilimkar wrote:
> Commit bbd707ac {ARM: omap2: use machine specific hook for late init}
> accidentally added two declarations for omap4430_init_late().
>
> Remove the duplicate declaration.
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>   arch/arm/mach-omap2/common.h |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 948bcaa..e0f9ea7 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -108,7 +108,6 @@ void omap35xx_init_late(void);
>   void omap3630_init_late(void);
>   void am35xx_init_late(void);
>   void ti81xx_init_late(void);
> -void omap4430_init_late(void);
>   int omap2_common_pm_late_init(void);
>
>   #if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
>
Can you pick this up ?

Regards,
Santosh
