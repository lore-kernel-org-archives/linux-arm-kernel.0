From: leoyang.li@nxp.com (Yang-Leo Li)
Date: Fri, 26 Aug 2016 16:08:49 +0000
Subject: [linux-devel] [PATCH 02/10] dt-bindings: esdhc: Update bindings
 for	LS1012A
In-Reply-To: <1472207269-18499-2-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <1472207269-18499-2-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <AM2PR04MB07709867FC1968AAB4B6FE208FEC0@AM2PR04MB0770.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-devel-bounces at gforge.freescale.net [mailto:linux-devel-
> bounces at gforge.freescale.net] On Behalf Of Bhaskar Upadhaya
> Sent: Friday, August 26, 2016 5:28 AM
> To: devicetree at vger.kernel.org; shawnguo at kernel.org
> Cc: oss at buserror.net; linux-devel at gforge.freescale.net; Bhaskar U
> <bhaskar.upadhaya@nxp.com>; linux-arm-kernel at lists.infradead.org
> Subject: [linux-devel] [PATCH 02/10] dt-bindings: esdhc: Update bindings for
> LS1012A
> 
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index dedfb02..3257b4a 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -7,9 +7,9 @@ This file documents differences between the core properties
> described  by mmc.txt and the properties used by the sdhci-esdhc driver.
> 
>  Required properties:
> +  - compatible : "fsl,mpc8378-esdhc", "fsl,ls1012a-esdhc0", "fsl,ls1012a-
> esdhc1".

What does it mean for esdhc0 and esdhc1?  If these are two different controllers used on the same chip, please describe what is the difference.  It is not clear from the name itself.

>    - interrupt-parent : interrupt source phandle.
>    - clock-frequency : specifies eSDHC base clock frequency.
> -
>  Optional properties:
>    - sdhci,wp-inverted : specifies that eSDHC controller reports
>      inverted write-protect state; New devices should use the generic
> --
> 1.9.1
> 
> _______________________________________________
> linux-devel mailing list
> linux-devel at gforge.freescale.net
> http://gforge.freescale.net/mailman/listinfo/linux-devel
