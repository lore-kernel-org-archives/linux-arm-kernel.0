From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 09:44:00 +0100
Subject: [RFC PATCH v2 04/14] dt-bindings: interrupt-controller: Add
 suniv interrupt-controller
In-Reply-To: <e51824832fac0b981cf886f25efc25056d573da4.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <e51824832fac0b981cf886f25efc25056d573da4.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <20181120084400.sn64fdxbpztaw26h@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 18, 2018 at 05:17:03PM +0300, Mesih Kilinc wrote:
> Add compatible string for Alwinner suniv F1C100s SoC interrupt
> controller which is stripped version of sun4i
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt  | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
> index b290ca1..e04ddb4 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
> @@ -2,7 +2,10 @@ Allwinner Sunxi Interrupt Controller
>  
>  Required properties:
>  
> -- compatible : should be "allwinner,sun4i-a10-ic"
> +- compatible: should be "allwinner,<soc-familiy>-<soc-name>-ic" to identify

There's no need to define the pattern, just list the compatibles
supported. Otherwise, you give the idea that all the combinations are
supported, and they aren't.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/e7506352/attachment-0001.sig>
