From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 12 Nov 2017 02:27:15 +0100
Subject: [PATCH v3 3/4] dt-bindings: iio: adc: update the doc for SAR ADC
In-Reply-To: <20171107053717.31948-2-yixun.lan@amlogic.com>
References: <20171107053717.31948-1-yixun.lan@amlogic.com>
 <20171107053717.31948-2-yixun.lan@amlogic.com>
Message-ID: <CAFBinCDLVijC9maBBMd_uwycO+CbtqvXCZNEiQz3TEZgN-DP5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 7, 2017 at 6:37 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
>
> Update the doc as the SAR ADC modules doesn't require "sana" clock.
>
> Singed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> index f413e82c8b83..1e6ee3deb4fa 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> @@ -15,7 +15,6 @@ Required properties:
>                         - "clkin" for the reference clock (typically XTAL)
>                         - "core" for the SAR ADC core clock
>                 optional clocks:
> -                       - "sana" for the analog clock
>                         - "adc_clk" for the ADC (sampling) clock
>                         - "adc_sel" for the ADC (sampling) clock mux
>  - vref-supply: the regulator supply for the ADC reference voltage
> --
> 2.14.1
>
