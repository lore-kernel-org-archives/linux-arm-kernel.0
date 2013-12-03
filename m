From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 21:32:54 +0800
Subject: [PATCH 1/3] ARM: imx27: add pwm pingrp
In-Reply-To: <1386069015-10718-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1386069015-10718-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20131203133252.GI13726@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 12:10:13PM +0100, Gwenhael Goavec-Merou wrote:
> From: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>

Applied all 3 with some small fix-ups (see replies to patch #2 and #3).

Shawn

> ---
>  arch/arm/boot/dts/imx27-pingrp.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-pingrp.h b/arch/arm/boot/dts/imx27-pingrp.h
> index f3fbf5a..edc1e90 100644
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
