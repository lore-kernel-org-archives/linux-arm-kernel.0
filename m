From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:22:40 +0200
Subject: [PATCH v2 15/38] ARM: orion5x: use gpio-keys and gpio-leds instead
 of gpio_keys/gpio_leds in edmini_v2
In-Reply-To: <1398202002-28530-16-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-16-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A280.5000200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> As noted by Sebastian Hesselbarth, the Device Tree nodes for GPIO keys
> and LEDs should be named gpio-keys and gpio-leds.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index d66d2fa..d85a206 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -41,7 +41,7 @@
>   		};
>   	};
>
> -	gpio_keys {
> +	gpio-keys {
>   		compatible = "gpio-keys";
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> @@ -52,7 +52,7 @@
>   		};
>   	};
>
> -	gpio_leds {
> +	gpio-leds {
>   		compatible = "gpio-leds";
>
>   		led at 1 {
>
