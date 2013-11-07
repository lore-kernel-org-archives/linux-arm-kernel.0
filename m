From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 7 Nov 2013 10:32:10 -0500
Subject: [PATCH v4 05/31] mtd: nand: pxa3xx: devicetree binding update
In-Reply-To: <1383837455-30721-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383837455-30721-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131107153210.GK8308@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 12:17:09PM -0300, Ezequiel Garcia wrote:
> Since the driver supports the new compatible string, the binding
> documentation must be updated to reflect it.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks for adding this, but please remember to update the Subject
string in the future.  Both this patch and the next one are changing the
Documentation/ portion of the tree, not drivers/.

And,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> diff --git a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
> index f1421e2..bed8390 100644
> --- a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
> @@ -2,7 +2,9 @@ PXA3xx NAND DT bindings
>  
>  Required properties:
>  
> - - compatible:		Should be "marvell,pxa3xx-nand"
> + - compatible:		Should be set to one of the following:
> +			marvell,pxa3xx-nand
> +			marvell,armada370-nand
>   - reg: 		The register base for the controller
>   - interrupts:		The interrupt to map
>   - #address-cells:	Set to <1> if the node includes partitions
> -- 
> 1.8.1.5
> 
