From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Dec 2015 10:09:42 +0530
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20151211043942.GQ3612@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-12-15, 17:58, Bartlomiej Zolnierkiewicz wrote:
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 48a0a55..616c2d0 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -50,6 +50,116 @@
>  		usbdrdphy1 = &usbdrd_phy1;
>  	};
>  
> +	cpu0_opp_table: opp_table0 {

Over and above what we are discussing in this thread, this should be
named cluster0_opp_table or cluster_a7_opp_table, not cpu0 as the
other one is never for cpu1 but cpu4.

-- 
viresh
