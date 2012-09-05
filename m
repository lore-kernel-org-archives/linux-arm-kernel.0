From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 5 Sep 2012 17:05:28 +0800
Subject: [PATCH 1/2] ARM: exynos: delete redundant HAVE_SCHED_CLOCK option
 in Kconfig
In-Reply-To: <227101cd8aea$06a06e10$13e14a30$%kim@samsung.com>
References: <1346406296-16223-1-git-send-email-Barry.Song@csr.com>
 <227101cd8aea$06a06e10$13e14a30$%kim@samsung.com>
Message-ID: <CAGsJ_4xCct_7H3oU6goNsXNqOxRZ57N_6qsAdoU37q1gLhUbTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/5 Kukjin Kim <kgene.kim@samsung.com>:
> Barry Song wrote:
>>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Kukjin, Thanks. i assume this will be taken by samsung tree. Who will
take care the other one:
http://www.spinics.net/lists/arm-kernel/msg191939.html

>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>> ---
>>  arch/arm/mach-exynos/Kconfig |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index b5b4c8c..3fd4ab3 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -243,7 +243,6 @@ config MACH_UNIVERSAL_C210
>>       select CPU_EXYNOS4210
>>       select S5P_HRT
>>       select CLKSRC_MMIO
>> -     select HAVE_SCHED_CLOCK
>>       select S5P_GPIO_INT
>>       select S5P_DEV_FIMC0
>>       select S5P_DEV_FIMC1
>> --
>> 1.7.0.4

-barry
