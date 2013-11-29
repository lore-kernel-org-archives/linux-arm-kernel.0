From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Nov 2013 10:28:55 +0800
Subject: [PATCHv2 1/3] ARM: imx27: add pingroups for cspi, sdhc and
 framebuffer
In-Reply-To: <1385623172-87429-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1385623172-87429-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20131129022853.GE5914@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 08:19:30AM +0100, Gwenhael Goavec-Merou wrote:
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Applied all 3, thanks.

Shawn

> ---
> Changelog:
> v2:
>  * pingroups entries are now sorted alphabetically;
>  * framebuffer pingroup is renamed: MX27_FB1_PINGRP1 -> MX27_FB_PINGRP1
> 
>  arch/arm/boot/dts/imx27-pingrp.h | 68 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-pingrp.h b/arch/arm/boot/dts/imx27-pingrp.h
> index 08d8d18..f3fbf5a 100644
> --- a/arch/arm/boot/dts/imx27-pingrp.h
> +++ b/arch/arm/boot/dts/imx27-pingrp.h
> @@ -13,6 +13,50 @@
>  
>  #include "imx27-pinfunc.h"
>  
> +#define MX27_CSPI1_PINGRP1 \
> +	MX27_PAD_CSPI1_MISO__CSPI1_MISO 0x0 \
> +	MX27_PAD_CSPI1_MOSI__CSPI1_MOSI 0x0 \
> +	MX27_PAD_CSPI1_SCLK__CSPI1_SCLK 0x0
> +
> +#define MX27_CSPI2_PINGRP1 \
> +	MX27_PAD_CSPI2_MISO__CSPI2_MISO 0x0 \
> +	MX27_PAD_CSPI2_MOSI__CSPI2_MOSI 0x0 \
> +	MX27_PAD_CSPI2_SCLK__CSPI2_SCLK 0x0
> +
> +#define MX27_CSPI3_PINGRP1 \
> +	MX27_PAD_SD1_CLK__CSPI3_SCLK 0x0 \
> +	MX27_PAD_SD1_D0__CSPI3_MISO 0x0 \
> +	MX27_PAD_SD1_CMD__CSPI3_MOSI 0x0
> +
> +#define MX27_FB_PINGRP1 \
> +	MX27_PAD_CLS__CLS 0x0 \
> +	MX27_PAD_CONTRAST__CONTRAST 0x0 \
> +	MX27_PAD_LD0__LD0 0x0 \
> +	MX27_PAD_LD1__LD1 0x0 \
> +	MX27_PAD_LD2__LD2 0x0 \
> +	MX27_PAD_LD3__LD3 0x0 \
> +	MX27_PAD_LD4__LD4 0x0 \
> +	MX27_PAD_LD5__LD5 0x0 \
> +	MX27_PAD_LD6__LD6 0x0 \
> +	MX27_PAD_LD7__LD7 0x0 \
> +	MX27_PAD_LD8__LD8 0x0 \
> +	MX27_PAD_LD9__LD9 0x0 \
> +	MX27_PAD_LD10__LD10 0x0 \
> +	MX27_PAD_LD11__LD11 0x0 \
> +	MX27_PAD_LD12__LD12 0x0 \
> +	MX27_PAD_LD13__LD13 0x0 \
> +	MX27_PAD_LD14__LD14 0x0 \
> +	MX27_PAD_LD15__LD15 0x0 \
> +	MX27_PAD_LD16__LD16 0x0 \
> +	MX27_PAD_LD17__LD17 0x0 \
> +	MX27_PAD_LSCLK__LSCLK 0x0 \
> +	MX27_PAD_OE_ACD__OE_ACD 0x0 \
> +	MX27_PAD_PS__PS 0x0 \
> +	MX27_PAD_REV__REV 0x0 \
> +	MX27_PAD_SPL_SPR__SPL_SPR 0x0 \
> +	MX27_PAD_HSYNC__HSYNC 0x0 \
> +	MX27_PAD_VSYNC__VSYNC 0x0
> +
>  #define MX27_FEC1_PINGRP1 \
>  	MX27_PAD_SD3_CMD__FEC_TXD0 0x0 \
>  	MX27_PAD_SD3_CLK__FEC_TXD1 0x0 \
> @@ -44,6 +88,30 @@
>  #define MX27_OWIRE1_PINGRP1 \
>  	MX27_PAD_RTCK__OWIRE 0x0
>  
> +#define MX27_SDHC1_PINGRP1 \
> +	MX27_PAD_SD1_CLK__SD1_CLK \
> +	MX27_PAD_SD1_CMD__SD1_CMD \
> +	MX27_PAD_SD1_D0__SD1_D0 \
> +	MX27_PAD_SD1_D1__SD1_D1 \
> +	MX27_PAD_SD1_D2__SD1_D2 \
> +	MX27_PAD_SD1_D3__SD1_D3
> +
> +#define MX27_SDHC2_PINGRP1 \
> +	MX27_PAD_SD2_CLK__SD2_CLK \
> +	MX27_PAD_SD2_CMD__SD2_CMD \
> +	MX27_PAD_SD2_D0__SD2_D0 \
> +	MX27_PAD_SD2_D1__SD2_D1 \
> +	MX27_PAD_SD2_D2__SD2_D2 \
> +	MX27_PAD_SD2_D3__SD2_D3
> +
> +#define MX27_SDHC3_PINGRP1 \
> +	MX27_PAD_SD3_CLK__SD3_CLK \
> +	MX27_PAD_SD3_CMD__SD3_CMD \
> +	MX27_PAD_SD3_D0__SD3_D0 \
> +	MX27_PAD_SD3_D1__SD3_D1 \
> +	MX27_PAD_SD3_D2__SD3_D2 \
> +	MX27_PAD_SD3_D3__SD3_D3
> +
>  #define MX27_UART1_PINGRP1 \
>  	MX27_PAD_UART1_TXD__UART1_TXD 0x0 \
>  	MX27_PAD_UART1_RXD__UART1_RXD 0x0
> -- 
> 1.8.3.2
> 
