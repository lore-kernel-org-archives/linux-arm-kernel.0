From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 05 Nov 2015 11:01:37 +0530
Subject: [PATCH v3 5/7] ARCH: EXYNOS: split up exynos5250 SoC specific PMU
 data
In-Reply-To: <563816F7.10502@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
 <1445864143-25695-6-git-send-email-pankaj.dubey@samsung.com>
 <563816F7.10502@samsung.com>
Message-ID: <563AE9B9.4090005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 03 November 2015 07:37 AM, Krzysztof Kozlowski wrote:
> On 26.10.2015 21:55, Pankaj Dubey wrote:
>> This patch splits up mach-exynos/pmu.c file, and moves exynos5250,
>> PMU configuration data and functions handing data into exynos5250
>> SoC specific PMU file mach-exynos/exynos5250-pmu.c.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/mach-exynos/Makefile         |   4 +-
>>   arch/arm/mach-exynos/exynos-pmu.h     |   1 +
>>   arch/arm/mach-exynos/exynos5250-pmu.c | 196 ++++++++++++++++++++++++++++++++++
>>   arch/arm/mach-exynos/pmu.c            | 180 -------------------------------
>>   4 files changed, 200 insertions(+), 181 deletions(-)
>>   create mode 100644 arch/arm/mach-exynos/exynos5250-pmu.c
>>
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Thanks.

Pankaj Dubey

> Best regards,
> Krzysztof
>
