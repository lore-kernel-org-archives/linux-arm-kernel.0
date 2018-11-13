From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Nov 2018 14:10:46 +0100
Subject: [PATCH v2 1/2] dt-bindings: gpu: mali-utgard: Add compatible for
 A64 Mali
In-Reply-To: <20181113120054.17639-1-jagan@amarulasolutions.com>
References: <20181113120054.17639-1-jagan@amarulasolutions.com>
Message-ID: <20181113131046.lh3h66sq5z47imw3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 05:30:53PM +0530, Jagan Teki wrote:
> Allwinner A64 has Mali-400MP2, so document the relevant compatible
> as "allwinner,sun50i-a64-mali"
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - New patch, separated from previous version patch.
> 
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> index 63cd91176a68..a0ee62a5b221 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> @@ -11,6 +11,7 @@ Required properties:
>        + allwinner,sun4i-a10-mali
>        + allwinner,sun7i-a20-mali
>        + allwinner,sun8i-h3-mali
> +      + allwinner,sun50i-a64-mali

It uses a reset property, so that must be documented as well later in
that file.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181113/b027d434/attachment.sig>
