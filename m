From: sbranden@broadcom.com (Scott Branden)
Date: Fri, 10 Oct 2014 12:12:32 -0700
Subject: [PATCH V4 7/7] ARM: multi_v7_defconfig: Enable ARCH_BCM_CYGNUS
 config
In-Reply-To: <8180880.ZD9iHlqhNz@wuerfel>
References: <1412894671-5921-8-git-send-email-sbranden@broadcom.com>
 <8180880.ZD9iHlqhNz@wuerfel>
Message-ID: <54382FA0.3070506@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-10-10 02:59 AM, Arnd Bergmann wrote:
> On Thursday 09 October 2014 15:44:31 Scott Branden wrote:
>> Enabled Broadcom Cygnus SoC family in multi_v7_defconfig by using
>> CONFIG_ARCH_BCM_CYGNUS=y.
>>
>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>   arch/arm/configs/multi_v7_defconfig |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 5fb95fb..d02f56d 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -17,6 +17,7 @@ CONFIG_MACH_ARMADA_38X=y
>>   CONFIG_MACH_ARMADA_XP=y
>>   CONFIG_MACH_DOVE=y
>>   CONFIG_ARCH_BCM=y
>> +CONFIG_ARCH_BCM_CYGNUS=y
>>   CONFIG_ARCH_BCM_MOBILE=y
>>   CONFIG_ARCH_BCM_5301X=y
>>   CONFIG_ARCH_BRCMSTB=y
>>
>
> Does this contain all the drivers you need that are enabled in cygnus_defconfig?
Will enable more - thanks for reminding.
>
> 	Arnd
>
