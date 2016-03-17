From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Mar 2016 14:42:37 +0100
Subject: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <56DEAFB7.50105@ti.com>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
 <20160204233950.GH4215@xsjsorenbubuntu> <56D04D17.6030502@ti.com>
 <20160226152714.GD3173@xsjsorenbubuntu> <56DEAFB7.50105@ti.com>
Message-ID: <56EAB44D.7020902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2016 11:55 AM, Grygorii Strashko wrote:
> Yeah. Thanks
>
> I'll re-send it after 4.6-rc.
> But What I'm not fully understand is how to get it merged taking into account that
> it touches few maches & clocksource :(

This is not a problem. Send it based on timers/core from the tip tree 
and Cc the maintainers for the maches dir. As soon as they ack the 
patches, I will merge it through my tree.

Thanks

   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
