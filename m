From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 16:58:09 +0800
Subject: [PATCH 1/3] ARM: imx27: add pwm0 pingrp
In-Reply-To: <1385822170-98486-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1385822170-98486-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20131203085808.GL10840@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 03:36:08PM +0100, Gwenhael Goavec-Merou wrote:
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

It seems there is only one pwm instance on imx27.  So pwm0 in the patch
subject sounds a little confusing.

Shawn

> ---
>  arch/arm/boot/dts/imx27-pingrp.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-pingrp.h b/arch/arm/boot/dts/imx27-pingrp.h
> index f3fbf5a..24df7dd7 100644
> --- a/arch/arm/boot/dts/imx27-pingrp.h
> +++ b/arch/arm/boot/dts/imx27-pingrp.h
> @@ -88,6 +88,9 @@
>  #define MX27_OWIRE1_PINGRP1 \
>  	MX27_PAD_RTCK__OWIRE 0x0
>  
> +#define MX27_PWM_PINGRP1 \
> +	MX27_PAD_PWMO__PWMO 0x0
> +
>  #define MX27_SDHC1_PINGRP1 \
>  	MX27_PAD_SD1_CLK__SD1_CLK \
>  	MX27_PAD_SD1_CMD__SD1_CMD \
> -- 
> 1.8.3.2
> 
