From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 14:19:27 -0700
Subject: [PATCH] arch/arm/mach-omap1/devices.c: Remove unecessary semicolon
In-Reply-To: <1347986174-30287-3-git-send-email-peter.senna@gmail.com>
References: <1347986174-30287-1-git-send-email-peter.senna@gmail.com>
 <1347986174-30287-3-git-send-email-peter.senna@gmail.com>
Message-ID: <20121008211926.GK13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Senna Tschudin <peter.senna@gmail.com> [120918 09:37]:
> Found by http://coccinelle.lip6.fr/
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
>  arch/arm/mach-omap1/devices.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
> index fa1fa4d..688b23a 100644
> --- a/arch/arm/mach-omap1/devices.c
> +++ b/arch/arm/mach-omap1/devices.c
> @@ -232,7 +232,7 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
>  
>  		omap_mmc_add("mmci-omap", i, base, size, irq,
>  				rx_req, tx_req, mmc_data[i]);
> -	};
> +	}
>  }
>  
>  #endif

Thanks applying into omap fixes branch.

Regards,

Tony
