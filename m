From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Nov 2014 13:49:57 +0100
Subject: [PATCH v4] clocksource: arch_timer: Allow the device tree to
 specify uninitialized timer registers
In-Reply-To: <11522840.iniX5CHHHk@diego>
References: <1412753627-28287-1-git-send-email-sonnyrao@chromium.org>
 <4822206.0yqmIumDEc@diego> <5475C802.4050903@linaro.org>
 <11522840.iniX5CHHHk@diego>
Message-ID: <5475CC75.5030300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2014 01:48 PM, Heiko St?bner wrote:
> Am Mittwoch, 26. November 2014, 13:30:58 schrieb Daniel Lezcano:
>> On 11/26/2014 01:06 PM, Heiko St?bner wrote:
>>> Hi Daniel,
>>>
>>> Am Mittwoch, 26. November 2014, 12:51:08 schrieb Daniel Lezcano:
>>>> Hi Doug, Olof,
>>>>
>>>> IIUC, it sounds like this patch is needed from some other patches in
>>>> arm-soc. Olof was proposing to take this patch through its tree to
>>>> facilitate the integration.
>>>>
>>>> Olof, is it this patch you were worried about ?
>>>
>>> I think this is one of two patches in question.
>>>
>>> "clocksource: arch_timer: Fix code to use physical timers when requested"
>>> [0] would be the second one.
>>>
>>> And the patch for arm-soc that Olof means would be "ARM: dts: rk3288: add
>>> arm,cpu-registers-not-fw-configured" [1].
>>
>> Ok, so IIUC, "clocksource: arch_timer: Fix code to use physical timers
>> when requested" should go via arm's tree, right ?
>
> If I'm reading Olof's irc-comments from yesterday correctly, that is right and
> the 3 patches should go in together:
>
> - "clocksource: arch_timer: Fix code to use physical timers
>    when requested" fixes the use of physical timers in general
> - "clocksource: arch_timer: Allow the device tree to specify uninitialized
>    timer registers" allows this to be set from dt
> - "ARM: dts: rk3288: add arm,cpu-registers-not-fw-configured" enables this on
>    rk3288

Ok, then I drop them from my tree and will let Olof to handle them.

Thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
