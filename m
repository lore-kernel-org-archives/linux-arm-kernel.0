From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 20 Mar 2015 16:11:04 +0100
Subject: [PATCH] exynos: pmu: use PS_HOLD based poweroff for all supported
 SoCs
In-Reply-To: <CAJKOXPe4=DHsV3_axDUhpimRaqSHA3=HLiSJ1K3DYZoGRRiTTg@mail.gmail.com>
References: <1423466741-11421-1-git-send-email-m.szyprowski@samsung.com>
 <CAJKOXPeeUjcwO6qBdHA8DJaviPxRwjAsSe7ciyGDFOUoNhZvcQ@mail.gmail.com>
 <CAJKOXPe4=DHsV3_axDUhpimRaqSHA3=HLiSJ1K3DYZoGRRiTTg@mail.gmail.com>
Message-ID: <550C3888.7050905@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-02-09 11:58, Krzysztof Kozlowski wrote:
> 2015-02-09 10:06 GMT+01:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>> 2015-02-09 8:25 GMT+01:00 Marek Szyprowski <m.szyprowski@samsung.com>:
>>> PS_HOLD based power off procedure is common for all Exynos SoCs, so use
>>> it for every Exynos SoC.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>   arch/arm/mach-exynos/pmu.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> I tried this on Trats2 board (Exynos 4412) and message "Power down
>> failed, please power off system manually." appears. Is it expected? Or
>> am I missing some patches (I applied this on top of next-20150129)?
> It was my fault (I left attached JIG cable which prevents power off).
> Now it works fine.
>
> Tested on Trats2 (Exynos4412):
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Patch also looks good, so:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Gentle ping for merging this in v4.1-next...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
