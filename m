From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 30 Mar 2018 13:05:45 +0200
Subject: [PATCH 2/3] dt-bindings: iio: adc: document the Meson AXG support
In-Reply-To: <20180326084629.100070-3-yixun.lan@amlogic.com>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
 <20180326084629.100070-3-yixun.lan@amlogic.com>
Message-ID: <CAFBinCBQS779Cfu-=nmcA5CJLETy25bYbeN1XgACQpRk4Yw6sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 10:46 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
>
> Update the documentation to expicitly support the Meson-AXG SoC.
>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> index 1e6ee3deb4fa..d1acd5ea2737 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> @@ -7,6 +7,7 @@ Required properties:
>                         - "amlogic,meson-gxbb-saradc" for GXBB
>                         - "amlogic,meson-gxl-saradc" for GXL
>                         - "amlogic,meson-gxm-saradc" for GXM
> +                       - "amlogic,meson-axg-saradc" for AXG
>                 along with the generic "amlogic,meson-saradc"
>  - reg:         the physical base address and length of the registers
>  - interrupts:  the interrupt indicating end of sampling
> --
> 2.15.1
>
