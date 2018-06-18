From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 18 Jun 2018 18:04:01 +0200
Subject: [PATCH v4 04/19] dt-bindings: sram: sunxi: Add A20 binding for
 the C1 SRAM region
In-Reply-To: <20180618145843.14631-5-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-5-paul.kocialkowski@bootlin.com>
Message-ID: <20180618160401.c6aqkeh6suime7xb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;5202;0c
On Mon, Jun 18, 2018 at 04:58:28PM +0200, Paul Kocialkowski wrote:
> This introduces a dedicated binding for the C1 SRAM region for the A20
> sunxi platform.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> index ddc82cbd7f4d..221fa7b42c18 100644
> --- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> @@ -35,6 +35,9 @@ The valid sections compatible for A10 are:
>  The valid sections compatible for A13 are:
>      - allwinner,sun5i-a13-sram-c1
>  
> +The valid sections compatible for A20 are:
> +    - allwinner,sun7i-a20-sram-c1

Same thing here, there's more supported SRAM than that. And maybe we
should just merge everything into the first patch? This looks like the
same commit over and over again.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180618/b7d236a9/attachment.sig>
