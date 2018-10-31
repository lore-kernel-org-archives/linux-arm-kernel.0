From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 Oct 2018 10:24:32 +0800
Subject: [PATCH v3 22/25] dt-bindings: sun6i-dsi: Add compatible for A64
 DPHY
In-Reply-To: <20181026144344.27778-23-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-23-jagan@amarulasolutions.com>
Message-ID: <CAGb2v65a-+-U74QWBvHLJ9e+_dWY3Cy+h9CfAFHqmFnB0GmcBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 10:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
> on the one on A31.
>
> Add A64 compatible and append A31 compatible as fallback.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - none
> Changes for v2:
> - new patch
>
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> index 9fa6e7a758ad..704fb31962f2 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> @@ -36,7 +36,7 @@ D-PHY
>
>  Required properties:
>    - compatible: value must be one of:
> -    * allwinner,sun6i-a31-mipi-dphy
> +    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"

The format for this is one "combination" per line. You need to keep the
original "allwinner,sun6i-a31-mipi-dphy".

ChenYu

>    - reg: base address and size of memory-mapped region
>    - clocks: phandles to the clocks feeding the DSI encoder
>      * bus: the DSI interface clock
> --
> 2.18.0.321.gffc6fa0e3
>
