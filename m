From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 4 May 2015 16:13:23 +0200
Subject: [PATCH v4 3/3] Documentation: mmc: Update Arasan SDHC
 documentation to support 4.9a version of Arasan SDHC controller.
In-Reply-To: <1430746792-32574-4-git-send-email-stripathi@apm.com>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
 <1430746792-32574-4-git-send-email-stripathi@apm.com>
Message-ID: <eb09e430-53dd-47ac-8395-6b5becf62517@BN1AFFO11FD044.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2015 03:39 PM, Suman Tripathi wrote:
> This patch updates Arasan SDHC documentation to support
> 4.9a version of Arasan SDHC controller.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 98ee2ab..6dd3d60 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> 
>  Required Properties:
> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> +                'arasan,sdhci-4.9a'
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> --
> 1.8.2.1
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
