From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 17 Feb 2018 22:21:27 +0100
Subject: [PATCH 10/10] MAINTAINERS: Add Actions Semi S900 pinctrl and gpio
 entries
In-Reply-To: <20180217204433.3095-11-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-11-manivannan.sadhasivam@linaro.org>
Message-ID: <9a7720b7-586e-8275-db41-19764e40f367@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.02.2018 um 21:44 schrieb Manivannan Sadhasivam:
> Add S900 pinctrl and gpio entries under ARCH_ACTIONS
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96b8b6531196..b718be5af680 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1126,11 +1126,15 @@ F:	arch/arm/boot/dts/owl-*
>  F:	arch/arm64/boot/dts/actions/
>  F:	drivers/clocksource/owl-*
>  F:	drivers/soc/actions/
> +F:	drivers/pinctrl/actions/*
> +F:	drivers/gpio/gpio-owl.c
>  F:	include/dt-bindings/power/owl-*
>  F:	include/linux/soc/actions/
>  F:	Documentation/devicetree/bindings/arm/actions.txt
>  F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
>  F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> +F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
> +F:	Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt

Please retain alphabetical ordering.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
