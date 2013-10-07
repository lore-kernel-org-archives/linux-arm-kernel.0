From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 07 Oct 2013 21:18:27 +0200
Subject: [GIT PULL]clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <5252EB22.2050506@linaro.org>
References: <1381159679-6528-1-git-send-email-dinguyen@altera.com>
 <5252DCB6.3070805@linaro.org> <5252EB22.2050506@linaro.org>
Message-ID: <52530903.4090709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 07:10 PM, John Stultz wrote:
> On 10/07/2013 09:09 AM, Daniel Lezcano wrote:
>> On 10/07/2013 05:27 PM, dinguyen at altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> Hi Thomas, John,
>>>
>>> I am hoping you can pull in these 2 patches. These 2 patches have
>>> been floating
>>> around for almost 2 months now. They are needed to get the Altera
>>> SOCFPGA
>>> booting again because of a DTS binding change in 3.12.
>>>
>>> The other change was correctly return the current clock counter.
>>>
>>> The discussion thread can be found here:
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198818.html
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198903.html
>>>
>>>
>>> This patch does not attempt or change the behaviour of the ordering
>>> of how a
>>> clocksource or clockevent is use. These 2 patches only enables a
>>> platform to boot.
>>
>> John,
>>
>> I agree with Dinh, these patches fixes a boot issue on Altera SOCFPGA
>> and should be merged.
>>
>
> Hey Dinh,
>      Thanks for persisting here! Sorry this has taken awhile. Just as an
> FYI, Daniel is maintaining the drivers/clocksource dir these days.
>
> So, I've not been following this closely, but if I recall we had a merge
> conflict that we backed out, since it seemed that everyone involved in
> this driver weren't working together. Then Thomas had some objections,
> but it *looks* like that's been resolved. So I don't have any objections
> at this point.

Yeah, it happens the same to me :)

> Daniel: if you want to pull these in to your tree, that's fine by me.

Ok, pulled to my tree.

Thanks !
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
