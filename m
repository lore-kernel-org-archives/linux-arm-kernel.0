From: nm@ti.com (Nishanth Menon)
Date: Fri, 28 Feb 2014 13:17:01 -0600
Subject: [PATCH 11/12] ARM: OMAP2: PRM: add support for OMAP2 specific
 clock providers
In-Reply-To: <1393579384-23440-12-git-send-email-t-kristo@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
 <1393579384-23440-12-git-send-email-t-kristo@ti.com>
Message-ID: <5310E0AD.6080104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2014 03:23 AM, Tero Kristo wrote:
> This patch adds support for initializing also omap2-prcm and omap2-scrm
> through DT.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/prm_common.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index b4c4ab9..878ae9f 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -475,6 +475,8 @@ static struct of_device_id omap_prcm_dt_match_table[] = {
>  	{ .compatible = "ti,am3-scrm" },
>  	{ .compatible = "ti,am4-prcm" },
>  	{ .compatible = "ti,am4-scrm" },
> +	{ .compatible = "ti,omap2-prcm" },
> +	{ .compatible = "ti,omap2-scrm" },
>  	{ .compatible = "ti,omap3-prm" },
>  	{ .compatible = "ti,omap3-cm" },
>  	{ .compatible = "ti,omap3-scrm" },
> 

probably needs Bindings documentation as well.

-- 
Regards,
Nishanth Menon
