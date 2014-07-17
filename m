From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Jul 2014 12:31:56 +0200
Subject: [PATCH v2 00/14] AT91: PIT: Cleanups and move to
 drivers/clocksource
In-Reply-To: <20140717095020.GB20328@lukather>
References: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140710075105.GA27469@lukather> <20140717095020.GB20328@lukather>
Message-ID: <53C7A61C.7030704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2014 11:50 AM, Maxime Ripard wrote:
> On Thu, Jul 10, 2014 at 09:51:05AM +0200, Maxime Ripard wrote:
>> Hi Daniel,
>>
>> On Tue, Jul 01, 2014 at 11:33:13AM +0200, Maxime Ripard wrote:
>>> Hi everyone,
>>>
>>> This series cleans up the PIT driver in order for it to not depend on
>>> anything in mach-at91 anymore, and in the end move it out of
>>> mach-at91.
>>>
>>> Along the way, these patches also do a bit of cleanup.
>>>
>>> This has been tested on a G45-EK without DT and an Xplained with DT.
>>>
>>
>> Even though most of this patches are not clocksource related, it would
>> be great if we could at least get an acked-by on the last patch that
>> moves the driver to drivers/clocksource, since it pretty much becomes
>> your burden :)
>
> Ping?

Hi,

I am in vacation right now. I will review the patches in the next two days.

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
