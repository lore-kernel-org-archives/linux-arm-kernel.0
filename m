From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 08 Feb 2017 13:35:48 +0100
Subject: [PATCH v3 0/7] Pad retentions support for Exynos5433
In-Reply-To: <20170208114615.c4wszjmnuackgzvx@dell>
References: <CGME20170130123837eucas1p13c607f81a1775a805740dccc87fe8b87@eucas1p1.samsung.com>
 <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
 <20170208114615.c4wszjmnuackgzvx@dell>
Message-ID: <b29e922c-4435-c9e8-2ab4-e4441eac3a09@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On 2017-02-08 12:46, Lee Jones wrote:
> On Mon, 30 Jan 2017, Marek Szyprowski wrote:
>> This patchset is a first step to add support for all power domains on
>> Exynos5433 SoCs. This patchset contains patches for Exynos pin control
>> driver and Exynos LPASS MFD driver, which are needed to make the
>> platform ready for adding power domains support.
>>
>> Patches in this patchset depends on each other. They are order in such a
>> way to make the changes bisectable.
>>
>> Patch #2 has compile dependency on #1.
>> Patch #3 has runtime dependency on commit fa59aa70907b2 ("soc: samsung:
>> 	pmu: Add dummy support for Exynos5433 SoC",
>> 	for-v4.11/drivers-soc-exynos-pmu-the-joy-never-ends branch).
>> Patch #4 has runtime dependency on #3.
>> Patch #5 has runtime dependency on commit 7547162ac3514 ("arm64: dts:
>> 	exynos: Add clocks to Exynos5433 LPASS module, next/dt64 branch).
>>
>> This patchset also directly depends on the "Move pad retention control to
>> Exynos pin controller driver" patchset:
>> https://www.spinics.net/lists/arm-kernel/msg556074.html
>>
>> Patches have been generated on top of linux-next from 30th January 2017
>> with the above mentioned patchset applied.
>>
>> This is a part of a larger task, which goal is to add support for power
>> domains on Exynos5433 SoCs / TM2 boards. First version of the all patches
>> needed to get it working have been pushed to the following git repo:
>> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.10-next-tm2-pd
>>
>> Best regards
>> Marek Szyprowski
>> Samsung R&D Institute Poland
> Looks like I reviewed v2.
>
> If the patches haven't changed that much, please apply my Acks to this
> set instead.  Anything that has changed, please leave them off and
> repost.

MFD related patches were not changed between v2 and v3.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
