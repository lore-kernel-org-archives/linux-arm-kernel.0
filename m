From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 26 Jan 2017 21:57:06 +0200
Subject: [PATCH v2 1/8] soc: samsung: pmu: Add dummy support for
 Exynos5433 SoC
In-Reply-To: <1485419634-28331-2-git-send-email-m.szyprowski@samsung.com>
References: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126083401eucas1p24b0f04c62332e0b6e446ecca83145bc5@eucas1p2.samsung.com>
 <1485419634-28331-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170126195706.an4ykk3bamvews6d@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 09:33:47AM +0100, Marek Szyprowski wrote:
> Add compatible for Exynos5433 SoC, so the driver will bind and let other
> drivers to use PMU regmap.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Thanks, applied.

I already have some PMU patches on separate branch (and tag), so this
lands on top of it.

Best regards,
Krzysztof
