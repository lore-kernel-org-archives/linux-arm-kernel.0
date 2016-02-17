From: xhnjupt@gmail.com (Han Xu)
Date: Thu, 18 Feb 2016 01:15:26 +0800
Subject: [PATCH v4 4/7] Documentation: fsl-quadspi: Add fsl, ls2080a-dspi
 compatible string
In-Reply-To: <1453793041-35868-4-git-send-email-yao.yuan@freescale.com>
References: <1453793041-35868-1-git-send-email-yao.yuan@freescale.com>
 <1453793041-35868-4-git-send-email-yao.yuan@freescale.com>
Message-ID: <20160217171526.GE16812@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 03:23:58PM +0800, Yuan Yao wrote:
> new compatible string: "fsl,ls2080a-qspi".
> 
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changed in v4:
> No changes.
> 
> Changed in v3:
> Add the modifier for new compatible string like:
> "fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
> 
> Changed in v2:
> Update my email to <yao.yuan@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> index fa77f87..1ad0fe3 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> @@ -1,7 +1,10 @@
>  ARM Freescale DSPI controller
>  
>  Required properties:
> -- compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi", "fsl,ls2085a-dspi"
> +- compatible : "fsl,vf610-dspi", "fsl,ls1021a-v1.0-dspi",
> +		"fsl,ls2085a-dspi"
> +		or
> +		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
>  - reg : Offset and length of the register set for the device
>  - interrupts : Should contain SPI controller interrupt
>  - clocks: from common clock binding: handle to dspi clock.
> -- 
> 2.1.0.27.g96db324
> 
> 
Acked-by: Han xu <han.xu@nxp.com>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
