From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 May 2012 13:39:06 -0700
Subject: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Tue, 24 Apr 2012 16:05:21 +0200")
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87bom5j8yd.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> This patchset makes some cleanup on these cpuidle drivers
> and consolidate the code across both architecture.

I think I said it before, but it's worth repeating: Very nice cleanup!
Thanks for your persistence.

I've now been through this version and I think it's ready for v3.5.  I
had a few very minor comments on some specific patches but made the
changes myself.  Please comment on those patches if you think my changes
are OK or not.  Also, I had to drop the Makefile change due to compile
problems.

With those changes made, and Reviewed-by and Tested-by tags added from
Santosh, I've created a branch[1] and will queue it for v3.5.  Any
additional patches can be sent against this branch.

> Tested on OMAP3 (igepV2).
> Partially tested on OMAP4 (pandaboard), without offlining the cpu1.

I've also tested on OMAP3430/n900, OMAP3530/Overo and OMAP4430/Pandabord
with CPU1 offlined so the deeper C-states are hit.  Combined with the
review and testing from Jean and Santosh (thanks!), I think this is
ready to go.

Thanks again for this great cleanup and consolidation,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/cleanup/omap-cpuidle
