From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 18 Feb 2014 11:46:50 +0100
Subject: [PATCH v6 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <CABuKBeJNwe5VXi2SvPX6Cne-iMHP7bbZarJDNAzuCMbg0E-bCQ@mail.gmail.com>
References: <1392027058-11680-1-git-send-email-ivan.khoronzhuk@ti.com>	<1392027058-11680-2-git-send-email-ivan.khoronzhuk@ti.com>	<52FA1E59.1000307@linaro.org>
 <CABuKBeJNwe5VXi2SvPX6Cne-iMHP7bbZarJDNAzuCMbg0E-bCQ@mail.gmail.com>
Message-ID: <53033A1A.5050404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2014 11:40 AM, Matthias Brugger wrote:
> 2014-02-11 13:58 GMT+01:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 02/10/2014 11:10 AM, Ivan Khoronzhuk wrote:
>>>
>>> Add broadcast clock-event device for the Keystone arch.
>>>
>>> The timer can be configured as a general-purpose 64-bit timer,
>>> dual general-purpose 32-bit timers. When configured as dual 32-bit
>>> timers, each half can operate in conjunction (chain mode) or
>>> independently (unchained mode) of each other.
>>>
>>> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>>> Acked-by: Santosh shilimkar <santosh.shilimkar@ti.com>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>> ---
>>
>>
>> Applied to my tree for 3.15
>
> I wanted to send a trivial follow-up patch, but I can't find the tree
> to which you have applied this patch.
> Would you mind to indicate me where I can find it.

Sure.

git://git.linaro.org/people/daniel.lezcano/linux.git #clockevents/3.15

Regards
   -- Daniel

>
> Cheers,
> Matthias
>
>>
>> --
>>   <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
