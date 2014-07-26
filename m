From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 27 Jul 2014 00:06:56 +0400
Subject: [PATCH] ARM: at91/dt: sam9x5: fix ADC compatible string
In-Reply-To: <1406038067-14697-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1406038067-14697-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <53D40A60.2060100@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/22/2014 06:07 PM, Alexandre Belloni wrote:

> Use the correct compatible string for the ADC of the at91sam9x5 family of SoCs.

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   arch/arm/boot/dts/at91sam9x5.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 2c0d6ea3ab41..5d7cf394f537 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -964,7 +964,7 @@
>   			adc0: adc at f804c000 {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> -				compatible = "atmel,at91sam9260-adc";
> +				compatible = "atmel,at91sam9x5-adc";

    Actually, wildcards are not allowed in the "compatible" prop.

WBR, Sergei
