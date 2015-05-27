From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 28 May 2015 01:39:38 +0200
Subject: [PATCH v3 12/12] ARM: imx: move timer driver into
 drivers/clocksource
In-Reply-To: <20150527140448.GJ16165@dragon>
References: <1432308599-28643-13-git-send-email-shawn.guo@linaro.org>
 <1432530849-12312-1-git-send-email-shawn.guo@linaro.org>
 <5565BD93.50600@linaro.org> <20150527140448.GJ16165@dragon>
Message-ID: <556655BA.3020903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2015 04:04 PM, Shawn Guo wrote:
> On Wed, May 27, 2015 at 02:50:27PM +0200, Daniel Lezcano wrote:
>> On 05/25/2015 07:14 AM, Shawn Guo wrote:
>>> After the cleanup on imx timer driver, now it's ready to be moved into
>>> drivers/clocksource/.  Let's do it.
>>>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> I don't see the Kconfig change.
>
> As timer-imx-gpt is the only supported timer for i.MX, we use
> architecture option CONFIG_ARCH_MXC to control it for now.

Hi Shawn,

please use the same as:

https://lkml.org/lkml/2015/5/22/855

and then add in the platform's Kconfig the timer option as:

https://lkml.org/lkml/2015/5/22/937

Thanks

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
