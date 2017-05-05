From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 5 May 2017 10:36:52 +0800
Subject: [v2, 1/5] mmc: dt: add compatible into eSDHC required properties
In-Reply-To: <1493894940-47452-2-git-send-email-yangbo.lu@nxp.com>
References: <1493894940-47452-1-git-send-email-yangbo.lu@nxp.com>
 <1493894940-47452-2-git-send-email-yangbo.lu@nxp.com>
Message-ID: <20170505023651.GW18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 06:48:56PM +0800, Yangbo Lu wrote:
> This patch is to add compatible into eSDHC required properties.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- Added this patch.
> ---
>  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index dedfb02..b04b248 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -7,6 +7,7 @@ This file documents differences between the core properties described
>  by mmc.txt and the properties used by the sdhci-esdhc driver.
>  
>  Required properties:
> +  - compatible : should be "fsl,esdhc", or "fsl,<chip>-esdhc".

I think either supported <chip> or the compatible should be listed
explicitly.

Shawn

>    - interrupt-parent : interrupt source phandle.
>    - clock-frequency : specifies eSDHC base clock frequency.
>  
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
