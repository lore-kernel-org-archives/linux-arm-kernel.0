From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 29 Sep 2014 10:55:32 +0530
Subject: [PATCH v2 3/4] rtc: omap: Update Kconfig for OMAP RTC
In-Reply-To: <20140925151117.GL28045@saruman>
References: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
 <1411637529-18289-4-git-send-email-lokeshvutla@ti.com>
 <20140925151117.GL28045@saruman>
Message-ID: <5428ED4C.8030306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014 08:41 PM, Felipe Balbi wrote:
> On Thu, Sep 25, 2014 at 03:02:08PM +0530, Lokesh Vutla wrote:
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> RTC is present in AM43xx and DRA7xx also. Updating the
>> same in Kconfig.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>> Changes since v1:
>> 	- New patch
>>  drivers/rtc/Kconfig    | 6 +++---
>>  drivers/rtc/rtc-omap.c | 4 ++--
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index a168e96..b092e2f 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -971,11 +971,11 @@ config RTC_DRV_IMXDI
>>  	   will be called "rtc-imxdi".
>>  
>>  config RTC_DRV_OMAP
>> -	tristate "TI OMAP1"
>> -	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX
>> +	tristate "TI OMAP Real Time Clock"
>> +	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX || SOC_DRA7XX || SOC_AM43XX
> 
> do you mind if we just make this "depends on ARCH_OMAP || ARCH_DAVINCI" ? Pretty much
> every incarnation has this anyway.
Ok..will update it and repost.

Thanks and regards,
Lokesh
> 
