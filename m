From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 22 Oct 2013 23:00:33 +0200
Subject: [PATCH v2] clocksource: Provide timekeeping for efm32 SoCs
In-Reply-To: <20131022201001.GB27227@pengutronix.de>
References: <1380830189-21553-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5253ECC7.30700@linaro.org> <20131008145147.GP10079@pengutronix.de>
 <20131022201001.GB27227@pengutronix.de>
Message-ID: <5266E771.4070906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2013 10:10 PM, Uwe Kleine-K?nig wrote:
> On Tue, Oct 08, 2013 at 04:51:47PM +0200, Uwe Kleine-K?nig wrote:
>> Hello Daniel,
>>
>> On Tue, Oct 08, 2013 at 01:30:15PM +0200, Daniel Lezcano wrote:
>>> On 10/03/2013 09:56 PM, Uwe Kleine-K?nig wrote:
>>>> An efm32 features 4 16-bit timers with a 10-bit prescaler. This driver
>>>> provides clocksource and clock event device using one timer instance
>>>> each.
>>>>
>>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>>> ---
>>>
>>> Applied to my tree for 3.13
>> Thanks
> Where is your tree to be found? This commit isn't in
>
> 	git://git.linaro.org/people/dlezcano/linux.git clockevents/3.13
>
> and also it's not included in next-20131021.

Thanks for the heads up.

I synced my local tree with the tree:

git://git.linaro.org/people/dlezcano/linux.git

for the branch clockevents/3.13 and clockevents/3.12-fixes

I will send a PR as soon as I can.

Thanks
   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
