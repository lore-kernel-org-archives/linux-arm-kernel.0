From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 23 Oct 2013 08:21:23 +0530
Subject: [PATCH] hwmon: ntc_thermistor: Fix typo (pullup-uV -> pullup-uv)
In-Reply-To: <1382492690-4056-1-git-send-email-cw00.choi@samsung.com>
References: <1382492690-4056-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAHfPSqAEY+e9wF403xrJSR5Y7=PgJ1McnKMxd6HECXFPV7ZoeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 October 2013 07:14, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch fix typo of property name from 'pullup-uV' to 'pullup-uv'.
> The ntc_thermistor.c use 'pullup-uv' when parsing dt data.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks for the correction.

Acked-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> index 47ada1d..5d49f2b 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> @@ -49,7 +49,7 @@ adc at 12D10000 {
>         /* NTC thermistor is a hwmon device */
>         ncp15wb473 at 0 {
>                 compatible = "ntc,ncp15wb473";
> -               pullup-uV = <1800000>;
> +               pullup-uv = <1800000>;
>                 pullup-ohm = <47000>;
>                 pulldown-ohm = <0>;
>                 io-channels = <&adc 4>;
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shine bright,
(: Nav :)
