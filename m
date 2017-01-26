From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Jan 2017 08:15:42 +0100
Subject: [PATCH 1/2] soc: samsung: pmu: Remove unused and duplicated
 defines
In-Reply-To: <20170125193452.31768-1-krzk@kernel.org>
References: <CGME20170125193513epcas4p3630dd48974bedbe07a74a21d11500fe1@epcas4p3.samsung.com>
 <20170125193452.31768-1-krzk@kernel.org>
Message-ID: <20251f7e-310a-223e-3a35-7df5bc30352a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,


On 2017-01-25 20:34, Krzysztof Kozlowski wrote:
> The exynos-regs-pmu.h was never a complete list of PMU registers.  It
> contained a lot of holes for registers which are not used.  However, a
> lot of unused defines came with porting the code from vendor kernel.
>
> Few of defines were also duplicated.
>
> Remove them so the file will be slightly smaller.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for the cleanup!

If you are touching this, you may also want to unify multiple headers for
the Exynos PMU regs:
include/linux/soc/samsung/exynos-regs-pmu.h
linux/mfd/syscon/exynos4-pmu.h
linux/mfd/syscon/exynos5-pmu.h

 > [...]

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
