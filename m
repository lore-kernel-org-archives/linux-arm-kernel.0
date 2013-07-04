From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Jul 2013 04:53:27 -0700
Subject: [PATCH -next] ARM: OMAP2+: devices: remove duplicated include
 from devices.c
In-Reply-To: <CAPgLHd9rXBA_QtQqOj4JbcFpfPoRTN5Ac9m9ofbP2PKVSmgANA@mail.gmail.com>
References: <CAPgLHd9rXBA_QtQqOj4JbcFpfPoRTN5Ac9m9ofbP2PKVSmgANA@mail.gmail.com>
Message-ID: <20130704115327.GI5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [130619 17:07]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks applying into omap-for-v3.11/fixes. Looks like the reboot.h
duplicate has already been removed.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/devices.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index c0f99ab..8349238 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -15,7 +15,6 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/pinctrl/machine.h>
