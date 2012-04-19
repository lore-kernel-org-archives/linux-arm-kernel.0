From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Apr 2012 16:03:56 +0200
Subject: [PATCH 00/17][V2] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
In-Reply-To: <87vcl87am5.fsf@ti.com>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
 <87vcl87am5.fsf@ti.com>
Message-ID: <4F901B4C.2090905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2012 01:23 AM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> This patchset makes some cleanup on these cpuidle drivers
>> and consolidate the code across both architecture.
>
> Thanks for this really nice cleanup.  I have some comments on specific
> patches, but here's some general comments:
>
> Some minor comments:
>
> First, please be sure all patches have a descriptive changelog.  Yes,
> even simple ones need changelogs.  In particular, maintainers are
> looking for the "why" of a patch, not just the "what" or "how".
>
> Second, this series introduced a couple sparse warnings:
>
> /work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle44xx.c:134:1: warning: symbol 'omap4_idle_dev' was not declared. Should it be static?
> /work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle44xx.c:136:23: warning: symbol 'omap4_idle_driver' was not declared. Should it be static?

Ok, I probably missed it. I will fix that it in the next version.

Thanks for reviewing.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
