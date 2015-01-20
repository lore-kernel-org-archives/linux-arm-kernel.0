From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 13:50:39 +0000
Subject: [PATCH 1/7] mfd: menelaus: delete omap_has_menelaus
In-Reply-To: <1419702779-16001-2-git-send-email-aaro.koskinen@iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-2-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20150120135039.GL13701@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Dec 2014, Aaro Koskinen wrote:

> Delete unused macro.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  include/linux/mfd/menelaus.h | 6 ------
>  1 file changed, 6 deletions(-)

Applied, thanks.

> diff --git a/include/linux/mfd/menelaus.h b/include/linux/mfd/menelaus.h
> index f097e89..a1e12bf3 100644
> --- a/include/linux/mfd/menelaus.h
> +++ b/include/linux/mfd/menelaus.h
> @@ -38,10 +38,4 @@ extern int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV);
>  
>  extern int menelaus_set_regulator_sleep(int enable, u32 val);
>  
> -#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_MENELAUS)
> -#define omap_has_menelaus()	1
> -#else
> -#define omap_has_menelaus()	0
> -#endif
> -
>  #endif

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
