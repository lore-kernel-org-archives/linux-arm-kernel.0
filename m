From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 17 Sep 2017 09:37:43 +0200
Subject: [PATCH 3/4] arm: dts: exynos: add exynos5422 cpu
 capacity-dmips-mhz information
In-Reply-To: <20170830144120.9312-4-dietmar.eggemann@arm.com>
References: <20170830144120.9312-1-dietmar.eggemann@arm.com>
 <20170830144120.9312-4-dietmar.eggemann@arm.com>
Message-ID: <20170917073743.GD19716@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 03:41:19PM +0100, Dietmar Eggemann wrote:
> The following 'capacity-dmips-mhz' dt property values are used:
> 
> Cortex-A15: 1024, Cortex-A7: 539
> 
> They have been derived form the cpu_efficiency values:
> 
> Cortex-A15: 3891, Cortex-A7: 2048
> 
> by scaling them so that the Cortex-A15s (big cores) use 1024.
> 
> The cpu_efficiency values were originally derived from the "Big.LITTLE
> Processing with ARM Cortex?-A15 & Cortex-A7" white paper
> (http://www.cl.cam.ac.uk/~rdm34/big.LITTLE.pdf). Table 1 lists 1.9x
> (3891/2048) as the Cortex-A15 vs Cortex-A7 performance ratio for the
> Dhrystone benchmark.
> 
> The following platforms are affected once cpu-invariant accounting
> support is re-connected to the task scheduler:
> 
> odroidxu3, odroidxu3-lite, odroidxu4
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
