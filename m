From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 04 Oct 2012 12:01:32 -0700
Subject: [PATCH] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <506D52D2.9060105@ti.com>
References: <1349340644-13937-1-git-send-email-sboyd@codeaurora.org>
 <506D52D2.9060105@ti.com>
Message-ID: <506DDD0C.4080704@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/12 02:11, Santosh Shilimkar wrote:
>> @@ -75,6 +77,8 @@ config SOC_OMAP5
>>       select CPU_V7
>>       select ARM_GIC
>>       select HAVE_SMP
>> +    select HAVE_ARM_SCU if SMP
>> +    select HAVE_ARM_TWD if LOCAL_TIMERS
>>       select ARM_CPU_SUSPEND if PM
>>       select SOC_HAS_REALTIME_COUNTER
>>       select ARM_ARCH_TIMER
> Drop this change.
>
> With that fixed, for OMAP changes
>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks. Will drop both lines in this hunk.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
