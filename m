From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 31 Oct 2018 14:58:11 +0800
Subject: [PATCH v2 2/2] dt-bindings: Add compatible string for LS1028A-QDS
In-Reply-To: <1539760132-3386-2-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1539760132-3386-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <1539760132-3386-2-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <20181031065809.GH10386@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 11:49:48AM +0000, Bhaskar Upadhaya wrote:
> Signed-off-by: Sudhanshu Gupta <sudhanshu.gupta@nxp.com>
> Signed-off-by: Rai Harninder <harninder.rai@nxp.com>
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

The bindings patch should generally go before rather than after the one
using it in a series.

Shawn

> ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index ea08bf2..3e44804 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -163,6 +163,18 @@ LS1012A ARMv8 based QDS Board
>  Required root node properties:
>      - compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
>  
> +LS1028A SoC
> +Required root node properties:
> +    - compatible = "fsl,ls1028a";
> +
> +LS1028A ARMv8 based RDB Board
> +Required root node properties:
> +    - compatible = "fsl,ls1028a-rdb", "fsl,ls1028a"
> +
> +LS1028A ARMv8 based QDS Board
> +Required root node properties:
> +    - compatible = "fsl,ls1028a-qds", "fsl,ls1028a";
> +
>  LS1043A SoC
>  Required root node properties:
>      - compatible = "fsl,ls1043a";
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
