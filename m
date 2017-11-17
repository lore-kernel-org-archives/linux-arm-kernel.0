From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Nov 2017 14:02:18 +0100
Subject: [PATCH 1/5] dt-bindings: i2c: update documentation for the
 Meson-AXG
In-Reply-To: <20171117080236.32504-2-yixun.lan@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
 <20171117080236.32504-2-yixun.lan@amlogic.com>
Message-ID: <03c9ea24-5f8d-f5dd-6e96-f53f56db530c@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/2017 09:02, Yixun Lan wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> Update the doc to explicitly add Meson-AXG to support list
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
> index 611b934c7e10..3097d2b44dad 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
> @@ -2,6 +2,7 @@ Amlogic Meson I2C controller
>  
>  Required properties:
>   - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
> +						"amlogic,meson-axg-i2c"

Hi Yixun, Jian,

Maybe you should reformat by using :
- compatible: must be :
	"amlogic,meson6-i2c" for Meson8 and compatible SoCs
	"amlogic,meson-gxbb-i2c" for GXBB and compatible SoCs
	"amlogic,meson-axg-i2c"for AXG and compatible SoCs

Neil

>   - reg: physical address and length of the device registers
>   - interrupts: a single interrupt specifier
>   - clocks: clock for the device
> 
