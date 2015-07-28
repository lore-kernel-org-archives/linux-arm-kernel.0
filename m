From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 28 Jul 2015 16:15:12 +0800
Subject: [PATCH v2 2/2] ARM: at91: at91_dt_defconfig: enable ISI and ov2640
 support
In-Reply-To: <55B7312F.9040505@atmel.com>
References: <1434449315-9243-1-git-send-email-josh.wu@atmel.com>
 <1434449315-9243-2-git-send-email-josh.wu@atmel.com>
 <55B7312F.9040505@atmel.com>
Message-ID: <55B73A10.4040608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/28/2015 3:37 PM, Nicolas Ferre wrote:
> Le 16/06/2015 12:08, Josh Wu a ?crit :
>> Add Atmel-isi and ov2640 driver in defconfig
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> ---
>>
>> Changes in v2: None
>>
>>   arch/arm/configs/at91_dt_defconfig | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
>> index bcef49a..d089ec9 100644
>> --- a/arch/arm/configs/at91_dt_defconfig
>> +++ b/arch/arm/configs/at91_dt_defconfig
>> @@ -131,6 +131,12 @@ CONFIG_POWER_RESET=y
>>   CONFIG_WATCHDOG=y
>>   CONFIG_AT91SAM9X_WATCHDOG=y
>>   CONFIG_SSB=m
>> +CONFIG_MEDIA_SUPPORT=y
>> +CONFIG_MEDIA_CAMERA_SUPPORT=y
>> +CONFIG_V4L_PLATFORM_DRIVERS=y
>> +CONFIG_SOC_CAMERA=y
>> +CONFIG_VIDEO_ATMEL_ISI=y
>> +CONFIG_SOC_CAMERA_OV2640=y
> I would select this camera driver as a module. Your thoughts?

yes, I agree.
Do I need to resent the patch for this?

Best Regards,
Josh Wu

>
> Bye,
>
>>   CONFIG_FB=y
>>   CONFIG_FB_ATMEL=y
>>   CONFIG_BACKLIGHT_LCD_SUPPORT=y
>>
>
