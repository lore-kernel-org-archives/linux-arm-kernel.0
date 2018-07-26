From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Thu, 26 Jul 2018 19:59:12 +0200
Subject: [linux-sunxi] [PATCH v3.1 06/10] dt-bindings: clock:
 sun50i-a64-ccu: Add PLL_VIDEO[0-1] macros
In-Reply-To: <20180726171257.6688-7-icenowy@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io>
 <20180726171257.6688-7-icenowy@aosc.io>
Message-ID: <4645023.F7YpVDaJQ2@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?etrtek, 26. julij 2018 ob 19:12:53 CEST je Icenowy Zheng napisal(a):
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Allwinner A64 has two clock parents PLL_VIDEO0 and PLL_VIDEO1.
> 
> Include these macros on dt-bindings so-that the same can be
> used while defining CCU clock phadles.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes for v3.1:
> - none
> Changes for v3:
> - collect Rob r-w-b tag
> Changes for v2:
> - new patch
> 
>  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h
> b/include/dt-bindings/clock/sun50i-a64-ccu.h index
> d66432c6e675..d1d7d5b7d06a 100644
> --- a/include/dt-bindings/clock/sun50i-a64-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
> @@ -43,7 +43,9 @@
>  #ifndef _DT_BINDINGS_CLK_SUN50I_A64_H_
>  #define _DT_BINDINGS_CLK_SUN50I_A64_H_
> 
> +#define CLK_PLL_VIDEO0		7
>  #define CLK_PLL_PERIPH0		11
> +#define CLK_PLL_VIDEO1		15
> 
>  #define CLK_BUS_MIPI_DSI	28
>  #define CLK_BUS_CE		29

You should remove above definitions from drivers/clk/sunxi-ng/ccu-sun50i-a64.h

Best regards,
Jernej
