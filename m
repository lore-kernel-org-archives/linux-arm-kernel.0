From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 16 Nov 2012 14:37:40 +0100
Subject: [PATCH RESEND] ARM: at91: dt: evk-pro3: enable uart0 and uart2
In-Reply-To: <1352707769-7259-1-git-send-email-fabio.porcedda@gmail.com>
References: <1352707769-7259-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <50A641A4.2050702@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 09:09 AM, Fabio Porcedda :
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Fine, queued in at91-3.8-dt branch.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

You may need to pay attention to pinctrl that will appear in 3.8.

Best regards,

> ---
>  based on v3.7-rc5
> 
>  arch/arm/boot/dts/evk-pro3.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
> index ce959ee..96e50f5 100644
> --- a/arch/arm/boot/dts/evk-pro3.dts
> +++ b/arch/arm/boot/dts/evk-pro3.dts
> @@ -22,6 +22,14 @@
>  				status = "okay";
>  			};
>  
> +			usart0: serial at fffb0000 {
> +				status = "okay";
> +			};
> +
> +			usart2: serial at fffb8000 {
> +				status = "okay";
> +			};
> +
>  			usb1: gadget at fffa4000 {
>  				atmel,vbus-gpio = <&pioC 5 0>;
>  				status = "okay";
> 


-- 
Nicolas Ferre
