From: scott.wood@nxp.com (Scott Wood)
Date: Mon, 7 Mar 2016 17:23:17 +0000
Subject: [PATCH v3 1/2] Documentation: DT: Add entry for Freescale
 LS1043a-QDS board
References: <1457350232-12749-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <DB5PR0401MB1928313A537226265C54764291B10@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2016 05:39 AM, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> v3:
>  - No change.
> 
>  Documentation/devicetree/bindings/arm/fsl.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index 752a685..f504fdf 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -134,6 +134,7 @@ Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
>  LS1043A ARMv8 based RDB Board
>  Required root node properties:
>      - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
> +    - compatible = "fsl,ls1043a-qds", "fsl,ls1043a";

"fsl,ls1043a-qds" is required for the "LS1043A ARMv8 based RDB Board"?

-Scott
