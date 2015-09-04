From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 4 Sep 2015 08:19:07 +0530
Subject: [PATCHv7] ARM: exynos_defconfig: Enable LEDS for Odroid-XU3/XU4
In-Reply-To: <55E8E534.1040204@osg.samsung.com>
References: <1441303910-3266-1-git-send-email-linux.amoon@gmail.com>
 <55E8DDDD.80106@samsung.com> <55E8E534.1040204@osg.samsung.com>
Message-ID: <CANAwSgTKQ6WSRkL=f9FXUk1RmUNOEzmaQo8MbgMeEUS9vUsfPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On 4 September 2015 at 05:56, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Krzysztof,
>
> On 09/04/2015 01:55 AM, Krzysztof Kozlowski wrote:
>> On 04.09.2015 03:11, Anand Moon wrote:
>>> Earlier design of the LED for Odroid XU3 was using gpio-leds
>>> Now It was change to using both pwm-leds and gpio-leds.
>>
>> It is still not a reason for this change. gpio-leds were not enabled
>> before. This could be a valid reason of adding LEDS_PWM to existing
>> config LEDS_GPIO. But LEDS_GPIO were not enabled... so why the change on
>> the board from gpio->(gpio+pwm) means that we have to enable LEDS_GPIO?
>>
>
> Agreed, also the commit message doesn't explain why the heartbeat
> LED trigger is enabled as I mentioned in the previous version.
>
>> Actually I gave up on this and I wanted to change the commit message on
>> myself when applying. But discussion was brought up again so... clearly
>> we have different understanding of the meaning of "WHY". :)
>>
>> Best regards,
>> Krzysztof
>>
>
I give up. I will not resend any patch.
I don't own this changes.

sorry for the noise.

-Anand Moon
> Best regards,
> --
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
