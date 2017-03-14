From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 15:33:51 +0100
Subject: [PATCH v2 1/4] phy: exynos4: Remove duplicated defines of PHY
 register defines
In-Reply-To: <20170311182534.13345-2-krzk@kernel.org>
References: <20170311182534.13345-1-krzk@kernel.org>
 <20170311182534.13345-2-krzk@kernel.org>
 <CGME20170314143354epcas5p264689de8b8889e4e06a145d89b376581@epcas5p2.samsung.com>
Message-ID: <12641153.bQdFckdOQG@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 11, 2017 08:25:31 PM Krzysztof Kozlowski wrote:
> Phy drivers access PMU region through regmap provided by exynos-pmu
> driver.   However there is no need to duplicate defines for PMU
> registers.  Instead just use whatever is defined in exynos-regs-pmu.h.
> 
> Additionally MIPI PHY registers for Exynos5433 start from the same
> address as Exynos4 and Exynos5250 so re-use existing defines.
> 
> This reduces number of defines and allows removal of one header file.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
