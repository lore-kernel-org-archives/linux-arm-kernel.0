From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 4 Feb 2017 16:05:21 -0800
Subject: [PATCH v9 2/3] MAINTAINERS: add zx2967 watchdog controller driver
 to ARM ZTE architecture
In-Reply-To: <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org>
References: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
 <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org>
Message-ID: <4cba1be6-ee85-7371-ea02-1bf8e7eb628e@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2017 05:34 PM, Baoyou Xie wrote:
> Add the zx2967 watchdog controller driver as maintained by ARM ZTE
> architecture maintainers, as they're parts of the core IP.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I assume you'll submit this patch through the arm tree ?

Guenter

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edfdea3..275c434 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1990,11 +1990,13 @@ F:	drivers/clk/zte/
>  F:	drivers/reset/reset-zx2967.c
>  F:	drivers/soc/zte/
>  F:	drivers/thermal/zx*
> +F:	drivers/watchdog/zx2967_wdt.c
>  F:	Documentation/devicetree/bindings/arm/zte.txt
>  F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
>  F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
>  F:	Documentation/devicetree/bindings/soc/zte/
>  F:	Documentation/devicetree/bindings/thermal/zx*
> +F:	Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
>  F:	include/dt-bindings/soc/zx*.h
>
>  ARM/ZYNQ ARCHITECTURE
>
