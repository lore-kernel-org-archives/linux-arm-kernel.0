From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Apr 2016 12:16:58 +0100
Subject: [PATCH v5 2/7] arm64: dts: Add Broadcom Vulcan PMU in dts
In-Reply-To: <1461092062-7484-3-git-send-email-ashoks@broadcom.com>
References: <1461092062-7484-1-git-send-email-ashoks@broadcom.com>
 <1461092062-7484-3-git-send-email-ashoks@broadcom.com>
Message-ID: <20160420111658.GH11453@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 11:54:17AM -0700, Ashok Kumar wrote:
> Add "brcm,vulcan-pmu" compatible string for Broadcom Vulcan PMU.
> 
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/boot/dts/broadcom/vulcan.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/vulcan.dtsi b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> index 85820e2..34e11a9 100644
> --- a/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> @@ -86,7 +86,7 @@
>  	};
>  
>  	pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "brcm,vulcan-pmu", "arm,armv8-pmuv3";
>  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>; /* PMU overflow */
>  	};
>  
> -- 
> 2.1.0
> 
