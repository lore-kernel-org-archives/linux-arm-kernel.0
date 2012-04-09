From: khilman@ti.com (Kevin Hilman)
Date: Mon, 09 Apr 2012 16:23:46 -0700
Subject: [PATCH 00/17][V2] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Wed, 4 Apr 2012 22:12:34 +0200")
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87vcl87am5.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> This patchset makes some cleanup on these cpuidle drivers
> and consolidate the code across both architecture.

Thanks for this really nice cleanup.  I have some comments on specific
patches, but here's some general comments:

Some minor comments:

First, please be sure all patches have a descriptive changelog.  Yes,
even simple ones need changelogs.  In particular, maintainers are
looking for the "why" of a patch, not just the "what" or "how".

Second, this series introduced a couple sparse warnings:

/work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle44xx.c:134:1: warning: symbol 'omap4_idle_dev' was not declared. Should it be static?
/work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle44xx.c:136:23: warning: symbol 'omap4_idle_driver' was not declared. Should it be static?

Thanks,

Kevin
