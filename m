From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 04 Jul 2014 13:32:09 +0200
Subject: [PATCH] ARM: dts: exynos5410: Fill in CPU clock-frequency
In-Reply-To: <53A7DCF8.4090108@samsung.com>
References: <1403466596-3347-1-git-send-email-afaerber@suse.de>
 <53A7DCF8.4090108@samsung.com>
Message-ID: <53B690B9.2090906@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.06.2014 09:53, schrieb Tarek Dakhran:
> On 06/22/2014 11:49 PM, Andreas F?rber wrote:
>> It's 1.6 GHz for the Cortex-A15.
>>
>> Avoids warnings like "/cpus/cpu at 0 missing clock-frequency property".
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>   arch/arm/boot/dts/exynos5410.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5410.dtsi
>> b/arch/arm/boot/dts/exynos5410.dtsi
>> index 3839c26..9d0b8cc 100644
>> --- a/arch/arm/boot/dts/exynos5410.dtsi
>> +++ b/arch/arm/boot/dts/exynos5410.dtsi
>> @@ -28,24 +28,28 @@
>>               device_type = "cpu";
>>               compatible = "arm,cortex-a15";
>>               reg = <0x0>;
>> +            clock-frequency = <1600000000>;
>>   
> 
> Reviewed-by: Tarek Dakhran<t.dakhran@samsung.com>

Ping? Seems really trivial...

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
