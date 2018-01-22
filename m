From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jan 2018 13:44:52 +0000
Subject: [PATCH] mfd: syscon: Remove unused Exynos PMU headers
In-Reply-To: <20180109185921.28260-1-krzk@kernel.org>
References: <20180109185921.28260-1-krzk@kernel.org>
Message-ID: <20180122134452.kx4fst5dxi4wllmr@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Jan 2018, Krzysztof Kozlowski wrote:

> Since commit 5812f0106c44 ("phy: exynos4: Remove duplicated defines of
> PHY register defines") and commit 7a66647b25b6 ("phy: exynos: Use one
> define for enable bit") all users of syscon Exynos PMU headers (for PHY
> drivers) are converted to use different headers so these can be removed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Actually I removed these headers in mentioned commits:
>  - https://www.spinics.net/lists/arm-kernel/msg568612.html
>  - https://www.spinics.net/lists/arm-kernel/msg568608.html
> however this part of patch disappeared when applying...
> ---
>  include/linux/mfd/syscon/exynos4-pmu.h | 21 ---------------------
>  include/linux/mfd/syscon/exynos5-pmu.h | 19 -------------------
>  2 files changed, 40 deletions(-)
>  delete mode 100644 include/linux/mfd/syscon/exynos4-pmu.h
>  delete mode 100644 include/linux/mfd/syscon/exynos5-pmu.h

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
