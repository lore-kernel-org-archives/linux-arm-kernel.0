From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Mon, 5 Nov 2012 12:29:06 +0530
Subject: [PATCH 05/15] ARM: OMAP2+: AM33XX: Update WKUP_M3 hwmod entry
 for reset status
In-Reply-To: <1351859566-24818-6-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-6-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <509763BA.1070402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/2/2012 6:02 PM, Vaibhav Bedia wrote:
> Add the reset status offset for WKUP_M3 in the hwmod data
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 

Thanks for the patch, Probably you can resubmit this patch separately
which can be merged independently from this patch-series.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav

> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 3c235d8..2e470ce 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -269,6 +269,7 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
>  		.omap4	= {
>  			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
>  			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
> +			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
>  			.modulemode	= MODULEMODE_SWCTRL,
>  		},
>  	},
> 
