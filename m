From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 10:41:53 +0200
Subject: [PATCH 2/5] dt-bindings: sunxi-sram: add binding for Allwinner
 H6 SRAM C
In-Reply-To: <20180722053955.25266-3-icenowy@aosc.io>
References: <20180722053955.25266-1-icenowy@aosc.io>
 <20180722053955.25266-3-icenowy@aosc.io>
Message-ID: <20180724084153.in6jl5mi3x4f3y3a@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2018 at 01:39:52PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC's DE3 needs the SRAM C section being claimed in the
> system controller to work, like A64 DE2.
> 
> As H6 and A64 system controller are quite similar, code is reused now,
> and the A64 fallback compatible string is added after the H6 compatible
> string.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> index c51ade86578c..6527a1a535a3 100644
> --- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> @@ -18,6 +18,7 @@ Required properties:
>      - "allwinner,sun8i-h3-system-control"
>      - "allwinner,sun50i-a64-sram-controller" (deprecated)
>      - "allwinner,sun50i-a64-system-control"
> +    - "allwinner,sun50i-h6-system-contorl", "allwinner,sun50i-a64-system-control"

                                     ^ control

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/56876721/attachment.sig>
