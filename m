From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Jan 2017 08:48:37 +0200
Subject: [PATCH v2 3/4] ARM64: dts: exynos5433: use macros for pinctrl
 configuration on Exynos5433
In-Reply-To: <20161230041421.24448-4-andi.shyti@samsung.com>
References: <20161230041421.24448-1-andi.shyti@samsung.com>
 <CGME20161230041427epcas1p1151d6e28fac143c63efaf4f7c8ed432d@epcas1p1.samsung.com>
 <20161230041421.24448-4-andi.shyti@samsung.com>
Message-ID: <20170106064837.dhtqh3knkciqomnr@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 01:14:20PM +0900, Andi Shyti wrote:
> Use the macros defined in include/dt-bindings/pinctrl/samsung.h
> instead of hardcoded values.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 348 +++++++++++----------
>  1 file changed, 175 insertions(+), 173 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
