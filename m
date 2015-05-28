From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 28 May 2015 10:20:58 +0200
Subject: [PATCH v3 12/12] ARM: imx: move timer driver into
 drivers/clocksource
In-Reply-To: <20150528011813.GK16165@dragon>
References: <1432308599-28643-13-git-send-email-shawn.guo@linaro.org>
 <1432530849-12312-1-git-send-email-shawn.guo@linaro.org>
 <5565BD93.50600@linaro.org> <20150527140448.GJ16165@dragon>
 <556655BA.3020903@linaro.org> <20150528011813.GK16165@dragon>
Message-ID: <5566CFEA.6080109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2015 03:18 AM, Shawn Guo wrote:
> On Thu, May 28, 2015 at 01:39:38AM +0200, Daniel Lezcano wrote:
>> please use the same as:
>>
>> https://lkml.org/lkml/2015/5/22/855
>>
>> and then add in the platform's Kconfig the timer option as:
>>
>> https://lkml.org/lkml/2015/5/22/937
>
> Okay, here it is.
>
> ------8<--------------------------
>
>  From fac8436459ad63531b2c39d4f060fd9420f93efd Mon Sep 17 00:00:00 2001
> From: Shawn Guo <shawn.guo@linaro.org>
> Date: Fri, 15 May 2015 15:41:00 +0800
> Subject: [PATCH] ARM: imx: move timer driver into drivers/clocksource
>
> After the cleanup on imx timer driver, now it's ready to be moved into
> drivers/clocksource/.  Let's do it.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
