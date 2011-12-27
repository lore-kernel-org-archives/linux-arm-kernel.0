From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Wed, 28 Dec 2011 00:08:56 +0100
Subject: [PATCH 3/3 v3] ARM: EXYNOS4: Delete the power domain code depend
 on samsung SoC
In-Reply-To: <013401cc99cd$92218f00$b664ad00$%kim@samsung.com>
References: <4EA690F4.6040608@samsung.com>
 <013401cc99cd$92218f00$b664ad00$%kim@samsung.com>
Message-ID: <4EFA5008.9070006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2011 03:09 AM, Kukjin Kim wrote:
> Chanwoo Choi wrote:
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-exynos4/Kconfig           |    5 -
>>  arch/arm/mach-exynos4/Makefile          |    1 -
>>  arch/arm/mach-exynos4/dev-pd.c          |  139 -------------------------------
>>  arch/arm/plat-samsung/Kconfig           |    8 --
>>  arch/arm/plat-samsung/Makefile          |    4 -
>>  arch/arm/plat-samsung/include/plat/pd.h |   30 -------
>>  arch/arm/plat-samsung/pd.c              |   95 ---------------------
>>  7 files changed, 0 insertions(+), 282 deletions(-)
>>  delete mode 100644 arch/arm/mach-exynos4/dev-pd.c
>>  delete mode 100644 arch/arm/plat-samsung/include/plat/pd.h
>>  delete mode 100644 arch/arm/plat-samsung/pd.c
...
> Well, I can't agree on this because you removed power domain codes which
> can be used for all of Samsung stuff for only EXYNOS4's generic power 
> domain even though it was used for only EXYNOS4.

In the same way the generic power domains can be used for "all Samsung stuff",
and there is no effort of converting something that doesn't even exist in
the mainline kernel.
More than that, any incoming power domain support seem to be already based on
the generic power domains...


--

Thanks,
Sylwester
