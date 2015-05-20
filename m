From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 20 May 2015 15:31:16 +0900
Subject: [PATCH] exynos: pmu: use PS_HOLD based poweroff for all supported
 SoCs
In-Reply-To: <020001d06609$74970ee0$5dc52ca0$@kernel.org>
References: <1423466741-11421-1-git-send-email-m.szyprowski@samsung.com>
 <CAJKOXPeeUjcwO6qBdHA8DJaviPxRwjAsSe7ciyGDFOUoNhZvcQ@mail.gmail.com>
 <CAJKOXPe4=DHsV3_axDUhpimRaqSHA3=HLiSJ1K3DYZoGRRiTTg@mail.gmail.com>
 <550C3888.7050905@samsung.com>
 <020001d06609$74970ee0$5dc52ca0$@kernel.org>
Message-ID: <CAJKOXPcFH4_udSmSjttON4AEJ84QUUu+8u-uaN1qtNeWU3NntA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-24 17:06 GMT+09:00 Kukjin Kim <kgene@kernel.org>:
> Marek Szyprowski wrote:
>>
>> Hello,
>>
> Hi,
>
>> On 2015-02-09 11:58, Krzysztof Kozlowski wrote:
>> > 2015-02-09 10:06 GMT+01:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>> >> 2015-02-09 8:25 GMT+01:00 Marek Szyprowski <m.szyprowski@samsung.com>:
>> >>> PS_HOLD based power off procedure is common for all Exynos SoCs, so use
>> >>> it for every Exynos SoC.
>> >>>
>> >>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> >>> ---
>> >>>   arch/arm/mach-exynos/pmu.c | 6 +++---
>> >>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> >> I tried this on Trats2 board (Exynos 4412) and message "Power down
>> >> failed, please power off system manually." appears. Is it expected? Or
>> >> am I missing some patches (I applied this on top of next-20150129)?
>> > It was my fault (I left attached JIG cable which prevents power off).
>> > Now it works fine.
>> >
>> > Tested on Trats2 (Exynos4412):
>> > Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> >
>> > Patch also looks good, so:
>> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> Gentle ping for merging this in v4.1-next...
>>
> OK, I'll queue this into v4.1-next/mach-samsung.

This patch is waiting enough time and it missed the 4.1. Kukjin, could
you apply it for 4.2? I'll apply it anyway to my tree.

Best regards,
Krzysztof
