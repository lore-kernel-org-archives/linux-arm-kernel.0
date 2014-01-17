From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jan 2014 09:56:38 -0800
Subject: [PATCH] clocksource: timer-sun5i: Switch to sched_clock_register()
In-Reply-To: <52D90060.5020104@linaro.org>
References: <1389922686-6249-1-git-send-email-sboyd@codeaurora.org>
 <52D90060.5020104@linaro.org>
Message-ID: <52D96ED6.20508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/14 02:05, Daniel Lezcano wrote:
> On 01/17/2014 02:38 AM, Stephen Boyd wrote:
>> The 32 bit sched_clock interface supports 64 bits since 3.13-rc1.
>> Upgrade to the 64 bit function to allow us to remove the 32 bit
>> registration interface.
>>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>
>> Cc'in Ingo because this is simple enough to probably just apply to
>> timers/core
>
> Hi Stephen,
>
> I applied your patch in my tree for 3.15.
>

I was hoping we could remove setup_sched_clock() in 3.14-rc1 timeline,
but if we delay this until 3.15 we'll have to wait another 3 months. Is
there any chance we can get this in for 3.14?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
