From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 30 Sep 2017 13:36:18 +0300
Subject: [PATCH 22/48] ARM: dts: gr-peach: Add user led device nodes
In-Reply-To: <cfce5ac1aaf08fc0920d6572779360f80e8f3489.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
 <cfce5ac1aaf08fc0920d6572779360f80e8f3489.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <e2e2b3a5-23b2-7f11-4fb3-2f835fdbc11a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 9/29/2017 2:53 PM, Simon Horman wrote:

> From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Add device nodes for user leds on gr-peach board.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/r7s72100-gr-peach.dts | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
> index bcfa6445bbaa..13d745bb56a5 100644
> --- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
> +++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
[...]
> @@ -51,6 +52,15 @@
>   			reg = <0x00600000 0x00200000>;
>   		};
>   	};
> +
> +leds {

    Not indented properly...

> +		status = "okay";
> +		compatible = "gpio-leds";
> +
> +		led1 {
> +			gpios = <&port6 12 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
>   };
>   
>   &pinctrl {

MBR, Sergei
