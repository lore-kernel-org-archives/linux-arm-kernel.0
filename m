From: marex@denx.de (Marek Vasut)
Date: Sat, 24 May 2014 13:21:32 +0200
Subject: [PATCH 1/3] dt: Add DT bindings documentation for SUNXI Security
 System
In-Reply-To: <1400771396-9686-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1400771396-9686-1-git-send-email-clabbe.montjoie@gmail.com>
 <1400771396-9686-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <201405241321.32147.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 22, 2014 at 05:09:54 PM, LABBE Corentin wrote:

Missing commit message. Please fix this and send a V2.

> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  Documentation/devicetree/bindings/crypto/sunxi-ss.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt new file mode
> 100644
> index 0000000..356563b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> @@ -0,0 +1,9 @@
> +* Allwinner Security System found on A20 SoC
> +
> +Required properties:
> +- compatible : Should be "allwinner,sun7i-a20-crypto".

Why sun7i-a20 ? Is the crypto unit different in other sunxi chips ? Can that not 
be described by DT props ?

> +- reg: Should contain the SS register location and length.

SS? What is that? Fix this text to be actually descriptive please.

> +- interrupts: Should contain the IRQ line for the SS.
> +- clocks : A phandle to the functional clock node of the SS module
> +- clock-names : Name of the functional clock, should be "ahb" and "mod".
> +

Best regards,
Marek Vasut
