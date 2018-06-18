From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 18 Jun 2018 18:02:50 +0200
Subject: [PATCH v4 01/19] dt-bindings: sram: sunxi: Add A13, A20 and A33
 SRAM controller bindings
In-Reply-To: <20180618145843.14631-2-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-2-paul.kocialkowski@bootlin.com>
Message-ID: <20180618160250.ik44c3gcbdxylmyd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 04:58:25PM +0200, Paul Kocialkowski wrote:
> This introduces dedicated bindings for the SRAM controllers found on the
> A13, A20 and A33 sunxi platforms.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Explaining why you need to add these new compatibles would be great.

> diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> index d087f04a4d7f..19cc0b892672 100644
> --- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> @@ -11,6 +11,9 @@ Controller Node
>  Required properties:
>  - compatible : should be:
>      - "allwinner,sun4i-a10-sram-controller"
> +    - "allwinner,sun5i-a13-sram-controller"
> +    - "allwinner,sun7i-a20-sram-controller"
> +    - "allwinner,sun8i-a33-sram-controller"

And I think Chen-Yu asked you to rename this compatible to
-system-controller for the previous iteration?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180618/5f55c0f0/attachment-0001.sig>
