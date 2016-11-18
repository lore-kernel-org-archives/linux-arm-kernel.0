From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Nov 2016 08:21:38 -0600
Subject: [PATCH 1/2] dt-bindings: ahci-fsl-qoriq: added explanation for
 reg-names
In-Reply-To: <1479369560-9188-1-git-send-email-yuantian.tang@nxp.com>
References: <1479369560-9188-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <20161118142138.jwehwhevgkhi6hww@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 03:59:19PM +0800, yuantian.tang at nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Added explanation for reg-names to make it more clear.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> index fc33ca0..80cf10c 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
> @@ -10,6 +10,8 @@ Required properties:
>  Optional properties:
>    - dma-coherent: Enable AHCI coherent DMA operation.
>    - reg-names: register area names when there are more than 1 register area.
> +		example: 'ahci' is for sata controller register.
> +			 'sata-ecc' is for sata ecc register.

This is not an example, but should be exactly what names are used.

When is there more than one area? That should be defined by the 
compatible string and spelled out here.

Rob
