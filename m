From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 May 2016 14:14:27 +0200
Subject: [PATCH 0114/1529] Fix typo
In-Reply-To: <20160521115109.5318-1-andrea.gelmini@gelma.net>
References: <20160521115109.5318-1-andrea.gelmini@gelma.net>
Message-ID: <1785036.RoNATgRSre@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrea,

Am Samstag, 21. Mai 2016, 13:51:09 schrieb Andrea Gelmini:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>

A series of 1529 patches? That's a bit extreme.

Also in future please use a sane subject line and additionally see comment 
below making the patch not valid.

> ---
>  arch/arm/mach-rockchip/pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
> index bee8c80..309d672 100644
> --- a/arch/arm/mach-rockchip/pm.c
> +++ b/arch/arm/mach-rockchip/pm.c
> @@ -280,7 +280,7 @@ static int rk3288_suspend_init(struct device_node *np)
> 
>  	rk3288_config_bootdata();
> 
> -	/* copy resume code and data to bootsram */
> +	/* copy resume code and data to bootram */

this is _not_ a typo, it is sram not regular ram

>  	memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
>  	       rk3288_bootram_sz);
