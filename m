From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 16 Jan 2017 12:56:28 +0900
Subject: [PATCH 1/4] ARM: EXYNOS: Remove Exynos4415 driver (SoC not
 supported anymore)
In-Reply-To: <20170114123642.15581-2-krzk@kernel.org>
References: <20170114123642.15581-1-krzk@kernel.org>
 <CGME20170114123711epcas1p382a72a6edbe757ca66eb370421e3f1e5@epcas1p3.samsung.com>
 <20170114123642.15581-2-krzk@kernel.org>
Message-ID: <587C446C.4090002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017? 01? 14? 21:36, Krzysztof Kozlowski wrote:
> Support for Exynos4415 is going away because there are no internal nor
> external users.
> 
> Since commit 46dcf0ff0de3 ("ARM: dts: exynos: Remove exynos4415.dtsi"),
> the platform cannot be instantiated so remove also the mach code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/mach-exynos/Kconfig   | 5 -----
>  arch/arm/mach-exynos/exynos.c  | 1 -
>  arch/arm/mach-exynos/suspend.c | 1 -
>  3 files changed, 7 deletions(-)

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
S/W Center, Samsung Electronics
