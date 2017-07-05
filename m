From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Wed, 05 Jul 2017 11:25:31 +0900
Subject: [PATCH] arm64: dts: zte: remove num-slots from zx296718
In-Reply-To: <1499159705-66870-1-git-send-email-shawn.lin@rock-chips.com>
References: <CGME20170704091525epcas4p1078f003a415e67c6915b3a9ff51bc23a@epcas4p1.samsung.com>
 <1499159705-66870-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <baa2991d-e6bd-8eb1-32f3-4531309d8951@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2017 06:15 PM, Shawn Lin wrote:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
> 
>  arch/arm64/boot/dts/zte/zx296718.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
> index d83bf78..b6e369d 100644
> --- a/arch/arm64/boot/dts/zte/zx296718.dtsi
> +++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
> @@ -311,7 +311,6 @@
>  			clock-frequency = <50000000>;
>  			clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
>  			clock-names = "biu", "ciu";
> -			num-slots = <1>;
>  			max-frequency = <50000000>;
>  			cap-sdio-irq;
>  			cap-sd-highspeed;
> @@ -336,7 +335,6 @@
>  			clock-frequency = <167000000>;
>  			clocks = <&topcrm SD1_AHB>, <&topcrm SD1_WCLK>;
>  			clock-names = "biu", "ciu";
> -			num-slots = <1>;
>  			max-frequency = <167000000>;
>  			cap-sdio-irq;
>  			cap-sd-highspeed;
> 
