From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Mar 2015 22:11:44 +0100
Subject: [PATCH 07/12] clocksource: qcom: Remove dead code
In-Reply-To: <55032AEA.3020304@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
 <1426270185-19510-8-git-send-email-sboyd@codeaurora.org>
 <55032913.2000506@linaro.org> <55032AEA.3020304@codeaurora.org>
Message-ID: <55035290.6060901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2015 07:22 PM, Stephen Boyd wrote:
> On 03/13/15 11:14, Daniel Lezcano wrote:
>> On 03/13/2015 07:09 PM, Stephen Boyd wrote:
>>> This code is no longer used now that mach-msm has been removed.
>>> Delete it.
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: David Brown <davidb@codeaurora.org>
>>> Cc: Bryan Huntsman <bryanh@codeaurora.org>
>>> Cc: Daniel Walker <dwalker@fifo99.com>
>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>> ---
>>>
>>> This can be acked and go through arm-soc or applied directly to
>>> clocksource
>>> tree.
>>>
>>>    drivers/clocksource/qcom-timer.c | 59
>>> ----------------------------------------
>>>    1 file changed, 59 deletions(-)
>>
>> Applied to my tree for 4.1.
>>
>
>
> Ah sorry, this one has to go with patch 1 through arm-soc, because it
> deletes symbols that patch 1 is using.

Ok. Removed from my tree.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
