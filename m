From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 13 Aug 2013 19:48:40 +0200
Subject: [PATCH v4 0/6] Armada 370/XP clocksource fixes
In-Reply-To: <20130813165223.GC25111@titan.lakedaemon.net>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <520A5D58.10902@linaro.org> <20130813165223.GC25111@titan.lakedaemon.net>
Message-ID: <520A7178.3040100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2013 06:52 PM, Jason Cooper wrote:
> Daniel,
> 
> On Tue, Aug 13, 2013 at 06:22:48PM +0200, Daniel Lezcano wrote:
>> On 08/13/2013 04:43 PM, Ezequiel Garcia wrote:
>>> This small patchset fixes a somewhat minor issue found in the clocksource
>>> driver for Armada 370/XP SoC.
>>>
>>> On one side the Armada 370 SoC has no 25 MHz fixed timer.
>>> On the other side the Armada XP SoC cannot work properly without such 25 MHz
>>> fixed timer selected, because otherwise the base clock frequency would vary
>>> when doing cpufreq frequency changes.
>>>
>>> Therefore we can consider the SoCs as not being compatible, being better to
>>> have two compatible strings, one for each SoC. The previous compatible and
>>> its behavior has been removed, considering there are no DT-enabled boards
>>> in use in the field.
>>>
>>> In addition, CLOCKSOURCE_OF_DECLARE is used to simplify the initialization.
>>>
>>> This patchset is based on tip/timers/core.
>>>
>>
>> Applied to my tree as 3.12 material.
> 
> Did you take patch #6 as well?

Yes. Not good ?


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
