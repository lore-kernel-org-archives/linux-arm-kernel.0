From: icenowy@aosc.io (icenowy at aosc.io)
Date: Mon, 04 Sep 2017 16:32:02 +0800
Subject: [PATCH v2 1/3] dt-bindings: add compatible string for Allwinner
 V3s SoC
In-Reply-To: <20170822052322.15338-1-icenowy@aosc.io>
References: <20170822052322.15338-1-icenowy@aosc.io>
Message-ID: <69e65e1018ccb64573ad7ec864ab9fa5@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-08-22 13:23?Icenowy Zheng ???
> The compatible string for Allwinner V3s SoC used to be missing.
> 
> Add it to the binding document.
> 
> Fixes: b074fede01c0 ("arm: sunxi: add support for V3s SoC")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Maxime, Chen-Yu, ping.

Could you queue this patchset to 4.15?

> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt
> b/Documentation/devicetree/bindings/arm/sunxi.txt
> index d2c46449b4eb..f35c6ada5a65 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -14,6 +14,7 @@ using one of the following compatible strings:
>    allwinner,sun8i-a83t
>    allwinner,sun8i-h2-plus
>    allwinner,sun8i-h3
> +  allwinner,sun8i-v3s
>    allwinner,sun9i-a80
>    allwinner,sun50i-a64
>    nextthing,gr8
