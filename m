From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 19 Apr 2017 13:00:08 +0200
Subject: [PATCH v4 3/6] mfd: exynos-lpass: Remove pad retention control
In-Reply-To: <20170411120231.hivtn6c7to4z2gu6@dell>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170323080348eucas1p29d1fb4eb06e4785d20341be7a374bfb3@eucas1p2.samsung.com>
 <1490256207-10061-4-git-send-email-m.szyprowski@samsung.com>
 <20170411120231.hivtn6c7to4z2gu6@dell>
Message-ID: <4646acab-261e-32ea-df63-6f8333f64e2d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 2017-04-11 14:02, Lee Jones wrote:
> On Thu, 23 Mar 2017, Marek Szyprowski wrote:
>
>> Pad retention should be controlled from pin control driver, so remove it
>> from Exynos LPASS driver. After this change, no more access to PMU regmap
>> is needed, so remove also the code for handling PMU regmap.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   .../bindings/mfd/samsung,exynos5433-lpass.txt           |  2 --
>>   drivers/mfd/exynos-lpass.c                              | 17 -----------------
>>   include/linux/mfd/syscon/exynos5-pmu.h                  |  3 ---
>>   3 files changed, 22 deletions(-)
> Applied, thanks.

When can I expect this (and the remaining patches from this patchset) to 
appear
in your -next branch?

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
