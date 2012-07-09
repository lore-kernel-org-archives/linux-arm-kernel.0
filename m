From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Mon, 9 Jul 2012 14:00:18 +0800
Subject: [PATCH v2 0/2] Watchdog: OMAP: bootstatus fix for omap3 and
 changes for the current watchdog framework
In-Reply-To: <4FFA73DB.1020009@ti.com>
References: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
 <4FFA73DB.1020009@ti.com>
Message-ID: <4FFA7372.4050201@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?09? 14:02, Vaibhav Hiremath ??:
>
> On 7/9/2012 10:09 AM, Zumeng Chen wrote:
>> Hello,
>>
>> The following patches based on the 3.5-rc6 from Wim, which
>> are based on:
>>
>> 1 ) bootstatus fix for omap3,
>>
>> 2 ) omap-wdt framework update cater for the current framework
>>      as Shubhrajyoti comments mentioned.
>>
>> Regards,
>> Zumeng
>>
>>    Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)
>>
>> Zumeng Chen (3):
>>        Watchdog: Omap: Changes for the new watchdog framework
>>        Watchdog: Omap: select watchdog core for framework change
>>        Watchdog: Omap: get the bootstatus for OMAP2Plus
>>
> It looks like you have manually created your cover letter, cover-letter
> says [0/2] but actually you have 3 patches in series.
>
>
> You should use following command to create cover letter,
>
> git format-patch --cover-letter<no of patches OR commits for patches>
OK, I'll re-send it again, so Please ignore this thread from now.

Many thanks for your kind reminder

Zumeng

>
>
> Thanks,
> Vaibhav
>
>>   arch/arm/mach-omap2/prcm.c  |    5 +-
>>   drivers/watchdog/Kconfig    |    1 +
>>   drivers/watchdog/omap_wdt.c |  338 ++++++++++++++++---------------------------
>>   drivers/watchdog/omap_wdt.h |    5 +
>>   4 files changed, 133 insertions(+), 216 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
