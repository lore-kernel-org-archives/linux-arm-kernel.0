From: horms@verge.net.au (Simon Horman)
Date: Thu, 25 Apr 2013 09:07:01 +0900
Subject: [RFC PATCH v3 13/17] ARM: dts: r8a7740: cpus/cpu nodes dts updates
In-Reply-To: <1366824502-19729-14-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366824502-19729-14-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130425000701.GD31061@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 06:28:18PM +0100, Lorenzo Pieralisi wrote:
> This patch updates the in-kernel dts files according to the latest cpus
> and cpu bindings updates for ARM.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/boot/dts/r8a7740.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index 798fa35..8a831e9 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -14,8 +14,12 @@
>  	compatible = "renesas,r8a7740";
>  
>  	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		cpu at 0 {
>  			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			reg = <0x0>;
>  		};
>  	};
>  };
> -- 
> 1.7.12
> 
> 
