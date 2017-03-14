From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 15:17:09 +0100
Subject: [PATCH 3/3] arm64: exynos: Enable Exynos PMU and PM domains
 drivers
In-Reply-To: <20170311213856.21701-4-krzk@kernel.org>
References: <20170311213856.21701-1-krzk@kernel.org>
 <20170311213856.21701-4-krzk@kernel.org>
 <CGME20170314141711epcas1p40ae1d73674e2c0eaa95da6d021456452@epcas1p4.samsung.com>
Message-ID: <5813978.inLg6sm6zB@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 11, 2017 11:38:56 PM Krzysztof Kozlowski wrote:
> Enable EXYNOS_PM_DOMAINS because recently Exynos5433 got support for
> Power Management domains.  The Exynos5433 pinctrl driver requires
> EXYNOS_PMU to get the syscon-regmap for PMU address space.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
