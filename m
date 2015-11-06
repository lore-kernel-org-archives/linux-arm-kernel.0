From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 Nov 2015 09:35:46 +0900
Subject: [PATCH v3 3/7] ARCH: EXYNOS: split up exynos3250 SoC specific PMU
 data
In-Reply-To: <563AE9B5.2020808@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
 <1445864143-25695-4-git-send-email-pankaj.dubey@samsung.com>
 <563813F8.6000201@samsung.com> <563AE9B5.2020808@samsung.com>
Message-ID: <563BF5E2.60902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 14:31, Pankaj Dubey wrote:
> Hi Krzysztof,
> 
> On Tuesday 03 November 2015 07:25 AM, Krzysztof Kozlowski wrote:
>> On 26.10.2015 21:55, Pankaj Dubey wrote:
>>> This patch splits up mach-exynos/pmu.c file, and moves exynos3250 PMU
>>> configuration data and functions handing those data into exynos3250
>>> SoC specific PMU file mach-exynos/exynos3250-pmu.c.
>>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> ---
>>>   arch/arm/mach-exynos/Makefile         |   2 +-
>>>   arch/arm/mach-exynos/exynos-pmu.h     |  47 +++++++++
>>>   arch/arm/mach-exynos/exynos3250-pmu.c | 175
>>> +++++++++++++++++++++++++++++++
>>>   arch/arm/mach-exynos/pmu.c            | 189
>>> +---------------------------------
>>>   4 files changed, 224 insertions(+), 189 deletions(-)
>>>   create mode 100644 arch/arm/mach-exynos/exynos-pmu.h
>>>   create mode 100644 arch/arm/mach-exynos/exynos3250-pmu.c
>>>

I spotted it now - please fix subject prefix in patches 3-6.
ARM: EXYNOS:

BR
