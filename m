From: oss@buserror.net (Scott Wood)
Date: Fri, 26 Aug 2016 17:30:28 -0500
Subject: [PATCH 05/10] dt-bindings: pci: Update bindings for LS1012A
In-Reply-To: <1472207269-18499-5-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <1472207269-18499-5-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1472250628.13245.6.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-26 at 15:57 +0530, Bhaskar Upadhaya wrote:
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
> ?Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 41e9f55..5755697 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -15,6 +15,7 @@ Required properties:
> ?- compatible: should contain the platform identifier such as:
> ?????????"fsl,ls1021a-pcie", "snps,dw-pcie"
> ?????????"fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
> +	"fsl,ls1012a-pcie", "fsl,ls1043a-pcie" ,"snps,dw-pcie"

Whitespace doesn't match.

Why are you listing both ls1012a and ls1043a together? ?Are they 100%
compatible?

Why are we updating all these bindings every time we come out with a new chip,
rather than having a <chip> pattern like we did in other bindings?

-Scott
