From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Apr 2016 12:15:48 +0100
Subject: [PATCH v5 1/7] Documentation: arm64: pmu: Add Broadcom Vulcan
 PMU binding
In-Reply-To: <1461092062-7484-2-git-send-email-ashoks@broadcom.com>
References: <1461092062-7484-1-git-send-email-ashoks@broadcom.com>
 <1461092062-7484-2-git-send-email-ashoks@broadcom.com>
Message-ID: <20160420111547.GG11453@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 11:54:16AM -0700, Ashok Kumar wrote:
> Document the compatible string for Broadcom Vulcan PMU.
> Also arranged the list in alphabetical order.
> 
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> Acked-by: Rob Herring <robh@kernel.org>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  Documentation/devicetree/bindings/arm/pmu.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 6eb73be..74d5417 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -22,10 +22,11 @@ Required properties:
>  	"arm,arm11mpcore-pmu"
>  	"arm,arm1176-pmu"
>  	"arm,arm1136-pmu"
> +	"brcm,vulcan-pmu"
> +	"cavium,thunder-pmu"
>  	"qcom,scorpion-pmu"
>  	"qcom,scorpion-mp-pmu"
>  	"qcom,krait-pmu"
> -	"cavium,thunder-pmu"
>  - interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
>                 interrupt (PPI) then 1 interrupt should be specified.
>  
> -- 
> 2.1.0
> 
