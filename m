From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 05 Jul 2014 06:06:35 +0900
Subject: [PATCH] ARM: dts: exynos5410: Fill in CPU clock-frequency
In-Reply-To: <53B690B9.2090906@suse.de>
References: <1403466596-3347-1-git-send-email-afaerber@suse.de>
 <53A7DCF8.4090108@samsung.com> <53B690B9.2090906@suse.de>
Message-ID: <53B7175B.1030109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/14 20:32, Andreas F?rber wrote:
> Am 23.06.2014 09:53, schrieb Tarek Dakhran:
>> On 06/22/2014 11:49 PM, Andreas F?rber wrote:
>>> It's 1.6 GHz for the Cortex-A15.
>>>
>>> Avoids warnings like "/cpus/cpu at 0 missing clock-frequency property".
>>>
>>> Signed-off-by: Andreas afaerber at suse.de>
>>> ---
>>>    arch/arm/boot/dts/exynos5410.dtsi | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5410.dtsi
>>> b/arch/arm/boot/dts/exynos5410.dtsi
>>> index 3839c26..9d0b8cc 100644
>>> --- a/arch/arm/boot/dts/exynos5410.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5410.dtsi
>>> @@ -28,24 +28,28 @@
>>>                device_type = "cpu";
>>>                compatible = "arm,cortex-a15";
>>>                reg =<0x0>;
>>> +            clock-frequency =<1600000000>;
>>>
>>
>> Reviewed-by: Tarek Dakhran<t.dakhran@samsung.com>
>
> Ping? Seems really trivial...
>
Will apply.

BTW Andreas, I can't use 'F?rber' in my git tree so which one is right 
or more preferred? Farber, Faerber, Ferber? Sorry.

Thanks,
Kukjin
