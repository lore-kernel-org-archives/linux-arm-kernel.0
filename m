From: robh@kernel.org (Rob Herring)
Date: Wed, 18 Jan 2017 15:46:03 -0600
Subject: [PATCH 30/37] dt-bindings: PCI: dra7xx: Add dt bindings to
 enable legacy mode
In-Reply-To: <1484216786-17292-31-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-31-git-send-email-kishon@ti.com>
Message-ID: <20170118214603.qnewy3sm6sgw7lbg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 03:56:19PM +0530, Kishon Vijay Abraham I wrote:
> Update device tree binding documentation of TI's dra7xx PCI
> controller to include property for enabling legacy mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 62f5f59..ed85e8e 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -39,6 +39,10 @@ DEVICE MODE
>   - interrupts : one interrupt entries must be specified for main interrupt.
>   - num-ib-windows : number of inbound address translation windows
>   - num-ob-windows : number of outbound address translation windows
> + - syscon-legacy-mode: phandle to the syscon dt node. The 1st argument should
> +		       contain the register offset within syscon and the 2nd
> +		       argument should contain the bit field for setting the
> +		       legacy mode

What's legacy mode?

>  
>  Optional Property:
>   - gpios : Should be added if a gpio line is required to drive PERST# line
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
