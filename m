From: a0131933@ti.com (Lokesh Vutla)
Date: Thu, 24 Sep 2015 10:15:30 +0530
Subject: [PATCH v3 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
In-Reply-To: <55DE9055.4090701@ti.com>
References: <1437657946-10733-1-git-send-email-lokeshvutla@ti.com>
 <55DE9055.4090701@ti.com>
Message-ID: <56037FEA.5070807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thursday 27 August 2015 09:51 AM, Lokesh Vutla wrote:
> Hi Paul,
> 
> On Thursday 23 July 2015 06:55 PM, Lokesh Vutla wrote:
>> This series implements lock and unlock functions for RTC and hooks
>> the same to DRA7 and AMx3xx hwmod.
>> This is dependent on the patch https://patchwork.kernel.org/patch/6578281/,
>> which is queued recently by Paul.
> Gentle ping on this series.
Do you have any comments on this series?

Thanks and regards,
Lokesh
> 
> Thanks and regards,
> Lokesh
>>
>> Changes since v2:
>> - Add kerneldoc for omap_hwmod_rtc_lock() function.
>>
>> Lokesh Vutla (3):
>>   ARM: hwmod: RTC: Add lock and unlock functions
>>   ARM: DRA7: RTC: Add lock and unlock functions
>>   ARM: AMx3xx: RTC: Add lock and unlock functions
>>
>>  arch/arm/mach-omap2/omap_hwmod.h                   |  2 +
>>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  2 +
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +
>>  arch/arm/mach-omap2/omap_hwmod_reset.c             | 65 ++++++++++++++++++++++
>>  4 files changed, 71 insertions(+)
>>
