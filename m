From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Jun 2017 14:54:28 -0500
Subject: [PATCH 1/5] dt-bindings: Update Broadcom STB binding
In-Reply-To: <20170616213703.21487-2-f.fainelli@gmail.com>
References: <20170616213703.21487-1-f.fainelli@gmail.com>
 <20170616213703.21487-2-f.fainelli@gmail.com>
Message-ID: <20170623195428.x7ckvni5t5gl4ukx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 02:36:59PM -0700, Florian Fainelli wrote:
> Update the Broadcom STB binding document with new compatible strings for
> the DDR PHY and memory controller found on newer chips.

The subject should be more specific what this patch is doing.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
> index 0d0c1ae81bed..790e6b0b8306 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
> @@ -164,6 +164,8 @@ Control registers for this memory controller's DDR PHY.
>  
>  Required properties:
>  - compatible     : should contain one of these
> +	"brcm,brcmstb-ddr-phy-v71.1"
> +	"brcm,brcmstb-ddr-phy-v72.0"
>  	"brcm,brcmstb-ddr-phy-v225.1"
>  	"brcm,brcmstb-ddr-phy-v240.1"
>  	"brcm,brcmstb-ddr-phy-v240.2"
> @@ -184,7 +186,9 @@ Sequencer DRAM parameters and control registers. Used for Self-Refresh
>  Power-Down (SRPD), among other things.
>  
>  Required properties:
> -- compatible     : should contain "brcm,brcmstb-memc-ddr"
> +- compatible     : should contain one of these
> +	"brcm,brcmstb-memc-ddr-rev-b.2.2"
> +	"brcm,brcmstb-memc-ddr"
>  - reg            : the MEMC DDR register range
>  
>  Example:
> -- 
> 2.9.3
> 
