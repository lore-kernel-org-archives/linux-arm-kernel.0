From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 22 Apr 2014 19:21:53 +0200
Subject: [PATCH 2/6] Documentation: bindings: add the berlin-achi
 compatible to the ahci platform
In-Reply-To: <1398181105-19714-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <5356A531.7030606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 05:38 PM, Antoine T?nart wrote:
> The berlin-achi driver allows Berlin SoCs to support their AHCI SATA controller.
> Add the compatible to the device tree bindings documentation.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 48b285ffa3a6..9987b63aaa10 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -7,7 +7,8 @@ Required properties:
>  - compatible        : compatible list, one of "snps,spear-ahci",
>                        "snps,exynos5440-ahci", "ibm,476gtr-ahci",
>                        "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci"
> -                      "fsl,imx6q-ahci" or "snps,dwc-ahci"
> +                      "fsl,imx6q-ahci", "snps,dwc-ahci" or
> +		      "marvell,berlin-ahci"

Besides the typo Thomas already mentioned, it looks like the compatibles
are indented by spaces while you have tabs.

Sebastian

>  - interrupts        : <interrupt mapping for SATA IRQ>
>  - reg               : <registers mapping>
>  
> 
