From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 20 Jan 2017 18:39:32 +0200
Subject: [PATCH v3 01/13] soc: samsung: pmu: Provide global function to
 get PMU regmap
In-Reply-To: <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134904eucas1p153a1d5b2ff9826c88293b6a8fe5140bc@eucas1p1.samsung.com>
 <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170120163932.4me7fyxxxuiegouf@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:48:41PM +0100, Marek Szyprowski wrote:
> PMU is something like a SoC wide service, so add a helper function to get
> PMU regmap. This will be used by other Exynos device drivers. This way it
> can be avoided to model this dependency in device tree (as phandles to PMU
> node) for almost every device in the SoC.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c       | 11 +++++++++++
>  include/linux/soc/samsung/exynos-pmu.h | 10 ++++++++++
>  2 files changed, 21 insertions(+)
> 

Thanks, applied.

I'll prepare a tag for pinctrl in a sec.

Best regards,
Krzysztof
