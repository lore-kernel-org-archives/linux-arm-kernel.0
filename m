From: xhnjupt@gmail.com (Han Xu)
Date: Thu, 18 Feb 2016 01:15:57 +0800
Subject: [PATCH v4 5/7] Documentation: fsl-quadspi: Add fsl, ls2080a-qspi
 compatible string
In-Reply-To: <1453793041-35868-5-git-send-email-yao.yuan@freescale.com>
References: <1453793041-35868-1-git-send-email-yao.yuan@freescale.com>
 <1453793041-35868-5-git-send-email-yao.yuan@freescale.com>
Message-ID: <20160217171557.GF16812@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 03:23:59PM +0800, Yuan Yao wrote:
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
> "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi"
> 
> Changed in v2:
> Update my email to <yao.yuan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mtd/fsl-quadspi.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> index 00c587b..0df2f3a 100644
> --- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> @@ -3,7 +3,9 @@
>  Required properties:
>    - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
>  		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
> -		 "fsl,ls1021-qspi"
> +		 "fsl,ls1021a-qspi"
> +		 or
> +		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi"
>    - reg : the first contains the register location and length,
>            the second contains the memory mapping address and length
>    - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
> -- 
> 2.1.0.27.g96db324
> 
> 
Acked-by: Han xu <han.xu@nxp.com>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
