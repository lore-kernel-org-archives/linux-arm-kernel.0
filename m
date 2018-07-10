From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 10 Jul 2018 11:29:36 +0200
Subject: [PATCH 1/3] dt-bindings: clk: g12a: New binding for Meson-G12A SoC
In-Reply-To: <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
Message-ID: <1531214976.2708.52.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-07-09 at 19:12 +0800, Jian Hu wrote:
> Add new binding for Meson-G12A SoC Everything-Else part

nitpick: I would prefer if the words 'clock' and 'controller' was somewhere in
the description.

Maybe "add new clock controller compatible for the EE domain of the g12a SoC" ?

> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> index e950599..0833006 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  		"amlogic,gxbb-clkc" for GXBB SoC,
>  		"amlogic,gxl-clkc" for GXL and GXM SoC,
>  		"amlogic,axg-clkc" for AXG SoC.
> +		"amlogic,g12a-clkc" for G12A SoC.
>  
>  - #clock-cells: should be 1.
>  
