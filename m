From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Nov 2017 14:16:24 +0100
Subject: [PATCH 1/4] documentation: Add compatibles for Amlogic Meson AXG
 pin controllers
In-Reply-To: <20171108064711.32376-1-yixun.lan@amlogic.com>
References: <20171108064711.32376-1-yixun.lan@amlogic.com>
Message-ID: <f1659ac3-84d7-f8a0-7335-a8f9ce351d79@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2017 07:47, Yixun Lan wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
> 
> Add compatibles for Amlogic Meson AXG pin controllers
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> index 2392557ede27..2c12f9789116 100644
> --- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> @@ -9,6 +9,8 @@ Required properties for the root node:
>  		      "amlogic,meson-gxbb-aobus-pinctrl"
>  		      "amlogic,meson-gxl-periphs-pinctrl"
>  		      "amlogic,meson-gxl-aobus-pinctrl"
> +		      "amlogic,meson-axg-periphs-pinctrl"
> +		      "amlogic,meson-axg-aobus-pinctrl"
>   - reg: address and size of registers controlling irq functionality
>  
>  === GPIO sub-nodes ===
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
