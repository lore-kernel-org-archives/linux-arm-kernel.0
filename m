From: david@lechnology.com (David Lechner)
Date: Thu, 27 Oct 2016 10:49:57 -0500
Subject: [PATCH 4/5] ARM: davinci: enable LEDs default-on trigger in
 default config
In-Reply-To: <669b14c2-7f62-35bc-c8a3-6dde05a99fb1@ti.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-5-git-send-email-david@lechnology.com>
 <669b14c2-7f62-35bc-c8a3-6dde05a99fb1@ti.com>
Message-ID: <be478f0a-bd10-7241-7e9d-20dfc1beaa30@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2016 06:29 AM, Sekhar Nori wrote:
> On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
>> The LEDs default-on trigger is nice to have. For example, it can be used
>> to configure a LED as a power indicator.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>  arch/arm/configs/davinci_all_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
>> index 9d7f0bc..e380743 100644
>> --- a/arch/arm/configs/davinci_all_defconfig
>> +++ b/arch/arm/configs/davinci_all_defconfig
>> @@ -181,6 +181,7 @@ CONFIG_LEDS_GPIO=m
>>  CONFIG_LEDS_TRIGGERS=y
>>  CONFIG_LEDS_TRIGGER_TIMER=m
>>  CONFIG_LEDS_TRIGGER_HEARTBEAT=m
>> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>
> Can this be module like rest of the triggers? It will come on later, but
> not sure if you care about the difference that much. Having it a module
> will be better for those boards that don't need it.
>
> Thanks,
> Sekhar
>

Yes, module is OK here.
