From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 22 Jun 2018 16:19:41 +0200
Subject: [PATCH v4 05/19] dt-bindings: sram: sunxi: Add A33 binding for
 the C1 SRAM region
In-Reply-To: <20180618145843.14631-6-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-6-paul.kocialkowski@bootlin.com>
Message-ID: <20180622141941.ckap4ydxqbihai6m@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 04:58:29PM +0200, Paul Kocialkowski wrote:
> This introduces a dedicated binding for the C1 SRAM region for the A33
> sunxi platform.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> index 221fa7b42c18..d8d1aac0840b 100644
> --- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> @@ -38,6 +38,9 @@ The valid sections compatible for A13 are:
>  The valid sections compatible for A20 are:
>      - allwinner,sun7i-a20-sram-c1
>  
> +The valid sections compatible for A33 are:
> +    - allwinner,sun8i-a33-sram-c1
> +

This is just a detail, but that got introduced with the A23, not the
A33, so it should be the A23 in the compatible instead. It applies for
the SRAM controller compatible too.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180622/c4220c1e/attachment.sig>
