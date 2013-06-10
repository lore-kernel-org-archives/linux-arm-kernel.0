From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 10 Jun 2013 19:06:38 +0200
Subject: [PATCH v4 2/6] clocksource: add Marvell Orion SoC timer
In-Reply-To: <51B6031B.4030204@gmail.com>
References: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1370856955-10514-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <51B5F8FE.5090508@linaro.org> <51B5FF51.6090708@gmail.com>
 <51B60267.9000600@linaro.org> <51B6031B.4030204@gmail.com>
Message-ID: <51B6079E.5090602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2013 06:47 PM, Sebastian Hesselbarth wrote:
> On 06/10/13 18:44, Daniel Lezcano wrote:
>> On 06/10/2013 06:31 PM, Sebastian Hesselbarth wrote:
>>> On 06/10/13 18:04, Daniel Lezcano wrote:
>>>> On 06/10/2013 11:35 AM, Sebastian Hesselbarth wrote:
>>>>> This patch add a DT enabled driver for timers found on Marvell Orion
>>>>> SoCs
>>>>> (Kirkwood, Dove, Orion5x, and Discovery Innovation). It installs a
>>>>> free-
>>>>> running clocksource on timer0 and a clockevent source on timer1.
>>>>> Corresponding device tree documentation is also added.
>>>>>
>>>>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>>>
>>>> It looks good for me.
>>>>
>>>> Sebastian,
>>>>
>>>> shall I take it through my tree (it will go to Thomas's tree) ?
>>>
>>> Daniel,
>>>
>>> I checked MAINTAINERS and thought clocksource, i.e. patch 2/6, would go
>>> through Thomas' or John's tree? If you want to take it, I am fine with
>>> it but guess I am not the one to choose here ;)
>>
>> Actually, I am giving a hand to John and Thomas. I take the patches for
>> clockevents (and also for clocksource if both are mixed and John did not
>> pick it yet) and Thomas pulls from my tree [1].
>>
>> If there is no dependency with any other patches of your patchset, which
>> seems to be the case, I will queue it for 3.11.
> 
> Ok, thanks!

I have a lot of ^M in the patch ... dos2unix removed them but I am
wondering how they get there ?


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
