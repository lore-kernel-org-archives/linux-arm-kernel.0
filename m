From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 04 Nov 2013 10:58:06 +0900
Subject: [PATCH] hwmon: ntc_thermistor: Fix typo (pullup-uV -> pullup-uv)
In-Reply-To: <1382492690-4056-1-git-send-email-cw00.choi@samsung.com>
References: <1382492690-4056-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <5276FF2E.6080508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping!

Thanks,
Chanwoo Choi

On 10/23/2013 10:44 AM, Chanwoo Choi wrote:
> This patch fix typo of property name from 'pullup-uV' to 'pullup-uv'.
> The ntc_thermistor.c use 'pullup-uv' when parsing dt data.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> index 47ada1d..5d49f2b 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> @@ -49,7 +49,7 @@ adc at 12D10000 {
>  	/* NTC thermistor is a hwmon device */
>  	ncp15wb473 at 0 {
>  		compatible = "ntc,ncp15wb473";
> -		pullup-uV = <1800000>;
> +		pullup-uv = <1800000>;
>  		pullup-ohm = <47000>;
>  		pulldown-ohm = <0>;
>  		io-channels = <&adc 4>;
> 
