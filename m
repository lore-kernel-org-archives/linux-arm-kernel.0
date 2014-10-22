From: santosh.shilimkar@gmail.com (Santosh Shilimkar)
Date: Wed, 22 Oct 2014 11:46:53 -0700
Subject: [PATCH 1/2] ARM: keystone_defconfig: enable dsp irq and gpio
 support
In-Reply-To: <544794B4.2090807@ti.com>
References: <1413811165-3928-1-git-send-email-grygorii.strashko@ti.com>
 <5446A354.8000902@gmail.com> <5446A4C5.6030308@ti.com>
 <544794B4.2090807@ti.com>
Message-ID: <5447FB9D.50504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/22/2014 04:27 AM, Grygorii Strashko wrote:
> Hi Santosh,
>
> On 10/21/2014 09:24 PM, Murali Karicheri wrote:
>> On 10/21/2014 02:17 PM, Santosh Shilimkar wrote:
>>> On 10/20/2014 06:19 AM, Grygorii Strashko wrote:
>>>> Enable DSP IRQ controller and GPIOs support for Keystone 2.
>>>>
>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>> ---
>>>> arch/arm/configs/keystone_defconfig | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm/configs/keystone_defconfig
>>>> b/arch/arm/configs/keystone_defconfig
>>>> index 932ae40..c9b0d1b 100644
>>>> --- a/arch/arm/configs/keystone_defconfig
>>>> +++ b/arch/arm/configs/keystone_defconfig
>>>> @@ -194,3 +194,5 @@ CONFIG_LEDS_TRIGGER_ONESHOT=y
>>>> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>>>> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>>>> CONFIG_LEDS_TRIGGER_GPIO=y
>>>> +CONFIG_KEYSTONE_IRQ=y
>>>> +CONFIG_GPIO_SYSCON=y
>>>>
>>> I will pick this one along with other three
>>> patches for next merge window.
>>>
>>> Thanks !!
>>>
>> Santosh,
>>
>> Need to fix the typo in the subject that I have commented.
>>
>
> Would you like me to re-send dts patches with updated subj?
>
No need to repost for that. I can fix that up while
applying.

Regards,
Santosh
