From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 16 Feb 2016 11:42:25 +0000
Subject: [PATCH] clocksource: arm_global_timer: register delay timer
In-Reply-To: <20160216112841.GA26773@axis.com>
References: <1439991818-31989-1-git-send-email-rabin.vincent@axis.com>
 <55D62468.4050404@linaro.org> <20160216112841.GA26773@axis.com>
Message-ID: <56C30B21.4000707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2016 11:28 AM, Rabin Vincent wrote:
> On Thu, Aug 20, 2015 at 09:03:04PM +0200, Daniel Lezcano wrote:
>> On 08/19/2015 03:43 PM, Rabin Vincent wrote:
>>> Provide a delay timer using the lower 32-bits of the global timer so
>>> that we can use that instead of having to calibrating delays.
>>>
>>> Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
>>
>> Applied to my tree for 4.4
>
> This seems to have got lost?  I don't see it in v4.4 or current mainline
> (v4.5-rc4).  It still applies cleanly.

Oops, right.

Fixed now [1]. Thanks for the heads up.

   -- Daniel

[1] 
https://git.linaro.org/people/daniel.lezcano/linux.git/commit/23cb25d0f407e83be10747258092843e8e20d535

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
