From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 30 May 2014 13:41:07 +0200
Subject: [PATCH] ARM: dts: exynos4: Fix reg sizes of GIC
In-Reply-To: <1400855960-22033-1-git-send-email-t.figa@samsung.com>
References: <1400855960-22033-1-git-send-email-t.figa@samsung.com>
Message-ID: <53886E53.70206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23.05.2014 16:39, Tomasz Figa wrote:
> This patch fixes reg entry sizes in GIC node that were not large enough
> to cover whole regions.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index b8ece4b..fbaf426 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -113,7 +113,7 @@
>  		compatible = "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;
>  		interrupt-controller;
> -		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
> +		reg = <0x10490000 0x10000>, <0x10480000 0x10000>;
>  	};
>  
>  	combiner: interrupt-controller at 10440000 {
> 

Ping.

Best regards,
Tomasz
