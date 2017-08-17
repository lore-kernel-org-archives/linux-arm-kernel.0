From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Aug 2017 10:14:06 +0200
Subject: [PATCH] dt-bindings: mmc: sh_mmcif: Document r8a7745 DT bindings
In-Reply-To: <1502816007-30186-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1502816007-30186-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20170817081406.GE26170@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 05:53:27PM +0100, Fabrizio Castro wrote:
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> index 703e18c..5ff1e12 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -12,6 +12,7 @@ Required properties:
>  	- "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
>  	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>  	- "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
> +	- "renesas,mmcif-r8a7745" for the MMCIF found in r8a7745 SoCs
>  	- "renesas,mmcif-r8a7778" for the MMCIF found in r8a7778 SoCs
>  	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>  	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> @@ -22,7 +23,7 @@ Required properties:
>  - interrupts: Some SoCs have only 1 shared interrupt, while others have either
>    2 or 3 individual interrupts (error, int, card detect). Below is the number
>    of interrupts for each SoC:
> -    1: r8a73a4, r8a7743, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
> +    1: r8a73a4, r8a7743, r8a7745, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
>      2: r8a7740, sh73a0
>      3: r7s72100
>  
> -- 
> 2.7.4
> 
