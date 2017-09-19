From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 19 Sep 2017 07:37:05 +0200
Subject: [PATCH 0/4] arm64: Add initial Actions Semi S700 and CubieBoard7
 support
In-Reply-To: <0a3e9a40-cb67-d2b2-7f06-fa0f24a4fb42@suse.de>
References: <20170911022241.11603-1-afaerber@suse.de>
 <6beabaab-d95f-4ac9-96f1-7c1c98bd7811@linaro.org>
 <0a3e9a40-cb67-d2b2-7f06-fa0f24a4fb42@suse.de>
Message-ID: <33bc3794-df11-6013-3b51-cb59f0476af1@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/2017 07:08, Andreas F?rber wrote:
> Hi Daniel,
> 
> Am 18.09.2017 um 23:50 schrieb Daniel Lezcano:
>> On 11/09/2017 04:22, Andreas F?rber wrote:
>>> Cc: devicetree at vger.kernel.org
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>
>>> Andreas F?rber (4):
>>>   dt-bindings: arm: actions: Add S700 and CubieBoard7
>>>   dt-bindings: timer: Add Actions Semi S700
>>>   clocksource: owl: Prepare S700
>>>   arm64: dts: actions: Add S700 and CubieBoard7
>>>
>>>  Documentation/devicetree/bindings/arm/actions.txt  |  15 ++
>>>  .../bindings/timer/actions,owl-timer.txt           |   1 +
>>
>> Usually sub system maintainers are also Cc'ed with Dt bindings
>> definitions and usage.
> 
> Your MAINTAINERS entry is lacking an entry for the bindings. Can you
> please fix that in linux-next? Then the next patches should reach you.
> 
> Actually I'm even surprised that it works for the drivers - I would
> expect a trailing "/" for the directory (see line 95ff).

Right, thanks for pointing this out, I will fix it.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
