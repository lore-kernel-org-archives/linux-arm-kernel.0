From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 22 Jan 2013 11:23:39 +0100
Subject: [PATCH 0/5] ARM: dts: OMAP3+: PWM support for TWL and selected
 boards
In-Reply-To: <50FE65E2.9020301@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
 <50FE65E2.9020301@ti.com>
Message-ID: <50FE68AB.3070909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 01/22/2013 11:11 AM, Peter Ujfalusi wrote:
> Hi Benoit,
> 
> I have prepared for you a branch from where you can pull this set on top of
> mainline v3.8-rc4:

Cool thanks,
I'll merged it in my branch.

Thanks,
Benoit

> 
> Regards,
> P?ter
> 
> ---
> The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:
> 
>   Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/omap-audio/linux-audio.git peter/for-benoit
> 
> for you to fetch changes up to b6230ae20bc018d042d703d0667ba9e7ac027ccb:
> 
>   ARM: dts: omap4-sdp: Add support for pwm-backlight (2013-01-22 11:08:37 +0100)
> 
> ----------------------------------------------------------------
> Peter Ujfalusi (5):
>       ARM: dts: twl4030: Add PWM support
>       ARM: dts: twl6030: Add PWM support
>       ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
>       ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and charging LED)
>       ARM: dts: omap4-sdp: Add support for pwm-backlight
> 
>  arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++----
>  arch/arm/boot/dts/omap4-sdp.dts       | 26 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/twl4030.dtsi        | 10 ++++++++++
>  arch/arm/boot/dts/twl6030.dtsi        | 12 ++++++++++++
>  4 files changed, 58 insertions(+), 4 deletions(-)
> 
> On 01/18/2013 03:36 PM, Peter Ujfalusi wrote:
>> Hi,
>>
>> Add the needed DT sections for twl4030 and twl6030 for the PWM childs.
>> Update the omap4-sdp to have working backlight and keypad/charging LED support.
>> Use the pwm-leds driver on BeagleBoard for the pmu_stat LED instead of the hacky
>> twl403-gpio mapped PWM.
>>
>> Regards,
>> Peter
>> ---
>> Peter Ujfalusi (5):
>>   ARM: dts: twl4030: Add PWM support
>>   ARM: dts: twl6030: Add PWM support
>>   ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
>>   ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and charging LED)
>>   ARM: dts: omap4-sdp: Add support for pwm-backlight
>>
>>  arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++----
>>  arch/arm/boot/dts/omap4-sdp.dts       | 26 ++++++++++++++++++++++++++
>>  arch/arm/boot/dts/twl4030.dtsi        | 10 ++++++++++
>>  arch/arm/boot/dts/twl6030.dtsi        | 12 ++++++++++++
>>  4 files changed, 58 insertions(+), 4 deletions(-)
>>
> 
> 
