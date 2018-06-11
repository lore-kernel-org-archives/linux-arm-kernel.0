From: horms@verge.net.au (Simon Horman)
Date: Mon, 11 Jun 2018 10:20:58 +0200
Subject: [PATCH/RFT 1/2] PCI: rcar: Add compatible string for r8a77965
In-Reply-To: <1528373494-18503-2-git-send-email-ykaneko0929@gmail.com>
References: <1528373494-18503-1-git-send-email-ykaneko0929@gmail.com>
 <1528373494-18503-2-git-send-email-ykaneko0929@gmail.com>
Message-ID: <20180611082057.wj7g3gwba3ikfvs3@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 09:11:33PM +0900, Yoshihiro Kaneko wrote:
> This patch adds support for r8a77965 (R-Car M3-N)
> 
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index 1fb614e..dd71cfe 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -8,6 +8,7 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
>  	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
>  	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
>  	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
> +	    "renesas,pcie-r8a77965" for the R8A77965 SoC;
>  	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
>  				     RZ/G1 compatible device.
>  	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
> -- 
> 1.9.1
> 
