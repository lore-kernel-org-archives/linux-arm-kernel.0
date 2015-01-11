From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 11 Jan 2015 21:51:12 +0100
Subject: [PATCH] clocksource: sirf: Remove unused variable
In-Reply-To: <CAGsJ_4zQqwNdu3z1hzuLd4gvxY8iA+9HfdoTE8_U2tDmRUBNYQ@mail.gmail.com>
References: <1418659160-2115-1-git-send-email-thierry.reding@gmail.com>
 <548F09B6.6010202@linaro.org>
 <CAGsJ_4zQqwNdu3z1hzuLd4gvxY8iA+9HfdoTE8_U2tDmRUBNYQ@mail.gmail.com>
Message-ID: <54B2E240.8030701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2015 04:58 PM, Barry Song wrote:
> 2014-12-16 0:17 GMT+08:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 12/15/2014 04:59 PM, Thierry Reding wrote:
>>>
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> Commit ef89af1f4380 ("clocksource: sirf: Remove hard-coded clock rate")
>>> removes all uses of the timer_div variable. Since the variable is no
>>> longer used it should be removed.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>
>>
>> Applied to my tree. Thanks!
>
> Daniel,
>
> i didn't find this commit in any tree in kernel.org. am i missing something?

Nope, I did probably something wrong.

> so i manually rebased "clocksource: marco: rename marco to atlas7"
> against this commit.
>
> can you help to apply the attached patch to your tree? i guess pulling
> by arm-soc will cause conflicts.

Ok, done. Both patches are in my tree [1].

Thanks
   -- Daniel

[1] 
https://git.linaro.org/people/daniel.lezcano/linux.git/shortlog/refs/heads/clockevents/3.20


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
