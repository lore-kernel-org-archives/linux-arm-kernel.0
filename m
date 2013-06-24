From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 24 Jun 2013 17:39:29 -0400
Subject: [PATCHv3 5/6] arm: omap2plus_defconfig: enable TI bandgap driver
In-Reply-To: <51C0C2A8.4020707@ti.com>
References: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
 <1370637968-23299-6-git-send-email-eduardo.valentin@ti.com>
 <51C0C2A8.4020707@ti.com>
Message-ID: <51C8BC91.6020707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 18-06-2013 16:27, Eduardo Valentin wrote:
> Tony,
> 
> On 07-06-2013 16:46, Eduardo Valentin wrote:
>> Enable the bandgap driver for TI SoCs thermal support.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Cc: AnilKumar Ch <anilkumar@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> 
> Is it possible for you to queue this one and patch 6 for 3.11?

Gentle reminder.

> 
> Cheers,
> 
>> ---
>>  arch/arm/configs/omap2plus_defconfig | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
>> index c1ef64b..6e6c494 100644
>> --- a/arch/arm/configs/omap2plus_defconfig
>> +++ b/arch/arm/configs/omap2plus_defconfig
>> @@ -151,6 +151,13 @@ CONFIG_W1=y
>>  CONFIG_POWER_SUPPLY=y
>>  CONFIG_SENSORS_LM75=m
>>  CONFIG_WATCHDOG=y
>> +CONFIG_THERMAL=y
>> +CONFIG_THERMAL_HWMON=y
>> +CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
>> +CONFIG_THERMAL_GOV_FAIR_SHARE=y
>> +CONFIG_THERMAL_GOV_STEP_WISE=y
>> +CONFIG_THERMAL_GOV_USER_SPACE=y
>> +CONFIG_CPU_THERMAL=y
>>  CONFIG_OMAP_WATCHDOG=y
>>  CONFIG_TWL4030_WATCHDOG=y
>>  CONFIG_MFD_TPS65217=y
>> @@ -237,6 +244,10 @@ CONFIG_RTC_DRV_TWL4030=y
>>  CONFIG_RTC_DRV_OMAP=y
>>  CONFIG_DMADEVICES=y
>>  CONFIG_DMA_OMAP=y
>> +CONFIG_TI_SOC_THERMAL=y
>> +CONFIG_TI_THERMAL=y
>> +CONFIG_OMAP4_THERMAL=y
>> +CONFIG_OMAP5_THERMAL=y
>>  CONFIG_EXT2_FS=y
>>  CONFIG_EXT3_FS=y
>>  # CONFIG_EXT3_FS_XATTR is not set
>>
> 
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/66cf164b/attachment.sig>
