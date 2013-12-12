From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Dec 2013 14:14:29 +0100
Subject: [PATCH] dt-bindings: fix example of allwinner interrupt controller
In-Reply-To: <bce591494e52baf5571db0c9a5a26d33d018fe49.1386765193.git.baruch@tkos.co.il>
References: <bce591494e52baf5571db0c9a5a26d33d018fe49.1386765193.git.baruch@tkos.co.il>
Message-ID: <20131212131429.GT3651@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Wed, Dec 11, 2013 at 02:33:13PM +0200, Baruch Siach wrote:
> The documented value of #interrupt-cells is 1.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
> index 3d3b2b9..32cec4b 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
> @@ -14,5 +14,5 @@ intc: interrupt-controller {
>  	compatible = "allwinner,sun4i-ic";
>  	reg = <0x01c20400 0x400>;
>  	interrupt-controller;
> -	#interrupt-cells = <2>;
> +	#interrupt-cells = <1>;
>  };

Nice catch, applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/637a0db9/attachment.sig>
