From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 16 Dec 2015 10:01:59 +0100
Subject: [PATCH] clocksource/drivers/pistachio: Fix wrong calculated
 clocksource read value
In-Reply-To: <20151216152807.23491eee@xhacker>
References: <1448466169-5230-1-git-send-email-jszhang@marvell.com>
 <56707F32.3030405@linaro.org> <20151216151125.1e91b4f4@xhacker>
 <20151216152807.23491eee@xhacker>
Message-ID: <56712887.5090506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2015 08:28 AM, Jisheng Zhang wrote:
> On Wed, 16 Dec 2015 15:11:25 +0800
> Jisheng Zhang  wrote:
>
>> Dear Daniel,
>>
>> On Tue, 15 Dec 2015 21:59:30 +0100 Daniel Lezcano wrote:
>>
>>> On 11/25/2015 04:42 PM, Jisheng Zhang wrote:
>>>> Let's assume the counter value is 0xf000000, the pistachio clocksource
>
> oops, sorry, should be 0xf0000000. Do I need to send a v2 patch?

Nope, I fixed it.



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
