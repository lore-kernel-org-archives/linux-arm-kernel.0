From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Tue, 15 Dec 2015 19:44:56 +0800
Subject: [PATCH v7 01/19] ARM64: Move PMU register related defines to
 asm/pmu.h
In-Reply-To: <566FFAB6.8060604@arm.com>
References: <1450169379-12336-1-git-send-email-zhaoshenglong@huawei.com>
 <1450169379-12336-2-git-send-email-zhaoshenglong@huawei.com>
 <566FFAB6.8060604@arm.com>
Message-ID: <566FFD38.7060803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/15 19:34, Marc Zyngier wrote:
> On 15/12/15 08:49, Shannon Zhao wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> To use the ARMv8 PMU related register defines from the KVM code,
>> we move the relevant definitions to asm/pmu.h header file.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> ---
>>   arch/arm64/include/asm/pmu.h   | 64 ++++++++++++++++++++++++++++++++++++++++++
>>   arch/arm64/kernel/perf_event.c | 36 +-----------------------
>>   2 files changed, 65 insertions(+), 35 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/pmu.h
>>
>> diff --git a/arch/arm64/include/asm/pmu.h b/arch/arm64/include/asm/pmu.h
>> new file mode 100644
>> index 0000000..4264ea0
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/pmu.h
>> @@ -0,0 +1,64 @@
>> +/*
>> + * Copyright (C) 2015 Linaro Ltd, Shannon Zhao
>
> Erm, not quite. You're simply moving existing code from one file to
> another. That doesn't change the copyright of said code, which reads:
>
>   * PMU support
>   *
>   * Copyright (C) 2012 ARM Limited
>   * Author: Will Deacon <will.deacon@arm.com>
>
> Please keep this mention in place.
>
Sure, will fix this. Thanks.

-- 
Shannon
