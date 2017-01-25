From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jan 2017 21:51:41 +0200
Subject: [PATCH 5/7] mfd: exynos-lpass: Remove pad retention control
In-Reply-To: <1485345031-2948-6-git-send-email-m.szyprowski@samsung.com>
References: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115104eucas1p219f763cea7fdb2dfea092d1f2a28fc31@eucas1p2.samsung.com>
 <1485345031-2948-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170125195141.zqz6temoeqkoaqpo@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 12:50:29PM +0100, Marek Szyprowski wrote:
> Pad retention should be controlled from pin control driver, so remove it
> from Exynos LPASS driver. After this change, no more access to PMU regmap
> is needed, so remove also the code for handling PMU regmap.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/mfd/samsung,exynos5433-lpass.txt           |  2 --
>  drivers/mfd/exynos-lpass.c                              | 17 -----------------
>  include/linux/mfd/syscon/exynos5-pmu.h                  |  3 ---
>  3 files changed, 22 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
