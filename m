From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Aug 2012 08:43:53 +0200
Subject: [PATCH] ARM i.MX: remove duplicated include from clk-imx21.c
In-Reply-To: <CAPgLHd_pYM3otnZBZ=nz7aYTP4dorBSjQtj=x9Z+zz7yr1NgSg@mail.gmail.com>
References: <CAPgLHd_pYM3otnZBZ=nz7aYTP4dorBSjQtj=x9Z+zz7yr1NgSg@mail.gmail.com>
Message-ID: <20120828064353.GO26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 09:48:11AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thanks

Sascha

> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-imx/clk-imx21.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
> index ea13e61..cf65148 100644
> --- a/arch/arm/mach-imx/clk-imx21.c
> +++ b/arch/arm/mach-imx/clk-imx21.c
> @@ -23,7 +23,6 @@
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/clkdev.h>
>  #include <linux/err.h>
>  
>  #include <mach/hardware.h>
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
