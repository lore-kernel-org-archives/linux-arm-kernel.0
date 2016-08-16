From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Aug 2016 17:13:34 +0800
Subject: [PATCH v2 1/2] dt: bindings: add binding for Allwinner A64 R_PIO
 pinctrl
In-Reply-To: <20160816050709.7412-1-icenowy@aosc.xyz>
References: <20160816050709.7412-1-icenowy@aosc.xyz>
Message-ID: <CAGb2v65ca+HFq9Mr21E7QSN845O2H7BYKg5uAmRhECJe5dK6ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 1:07 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Commit message please. :)

Something similar to the one in the pinctrl driver patch would do.

ChenYu

> ---
>  Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index 6961722..ee73f9f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -23,6 +23,7 @@ Required properties:
>    "allwinner,sun8i-h3-pinctrl"
>    "allwinner,sun8i-h3-r-pinctrl"
>    "allwinner,sun50i-a64-pinctrl"
> +  "allwinner,sun50i-a64-r-pinctrl"
>
>  - reg: Should contain the register physical address and length for the
>    pin controller.
> --
> 2.9.2
>
