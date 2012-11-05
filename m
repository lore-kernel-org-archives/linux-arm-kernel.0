From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Mon, 5 Nov 2012 12:49:49 +0530
Subject: [PATCH 07/15] ARM: OMAP2+: hwmod: Update the hwmod data for TPTCs
 in AM33XX
In-Reply-To: <1351859566-24818-8-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-8-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50976895.9040409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/2/2012 6:02 PM, Vaibhav Bedia wrote:
> Update the TPTC hwmod entry to reflect the fact that
> the idle and standby transitions are s/w controlled.
> 

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index ec3fbb2..7772c29 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -1827,6 +1827,7 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
>  	.class		= &am33xx_tptc_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
>  	.mpu_irqs	= am33xx_tptc0_irqs,
> +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
> 
