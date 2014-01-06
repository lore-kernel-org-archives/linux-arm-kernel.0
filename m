From: valentine.barshak@cogentembedded.com (Valentine)
Date: Mon, 06 Jan 2014 18:00:10 +0400
Subject: [PATCH] ARM: shmobile: lager: Enable VIN in defconfig
In-Reply-To: <52CAA705.7080909@cogentembedded.com>
References: <1388990626-21460-1-git-send-email-horms+renesas@verge.net.au>
 <52CAA705.7080909@cogentembedded.com>
Message-ID: <52CAB6EA.3010104@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2014 04:52 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 06-01-2014 10:43, Simon Horman wrote:
>
>> Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>   arch/arm/configs/lager_defconfig | 6 ++++++
>>   1 file changed, 6 insertions(+)
>
>> diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
>> index 883443f..7fe482d 100644
>> --- a/arch/arm/configs/lager_defconfig
>> +++ b/arch/arm/configs/lager_defconfig
>> @@ -90,6 +90,12 @@ CONFIG_RCAR_THERMAL=y
>>   CONFIG_REGULATOR=y
>>   CONFIG_REGULATOR_FIXED_VOLTAGE=y
>>   CONFIG_REGULATOR_GPIO=y
>> +CONFIG_MEDIA_SUPPORT=y
>> +CONFIG_MEDIA_CAMERA_SUPPORT=y
>> +CONFIG_V4L_PLATFORM_DRIVERS=y
>> +CONFIG_SOC_CAMERA=y
>> +CONFIG_SOC_CAMERA_PLATFORM=y
>> +CONFIG_VIDEO_RCAR_VIN=y
>
>     I'm afraid the VIN driver would be useless without ADV7180 codec driver.

Indeed.

>
> WBR, Sergei
>

Thanks,
Val.
