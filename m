From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 03 Apr 2013 15:52:58 -0700
Subject: [PATCH v2 00/18] ARM: OMAP5: PM: Add MPUSS suspend and CPUidle
 support
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:34:52 +0530")
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87hajnp6ph.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Here is the refreshed version(v2) of the OMAP5 PM suspport which was posted
> earlier (March 1st 2013). Patch-set incorporates comments from Nishant
> Menon (Thanks for review NM) and his acked-by tags. I would like to get this
> queued for 3.10 merge window if you are ok with the series.

I did a review of this series with several comments on the individual
patches.  

I've already queued most of the CPUidle fixes/cleanups in my
for_3.10/cleanup/cpuidle branch and will get that to Tony soon.  For the
rest, I suggest probably breaking it up into cleanup/consolidation stuff
and then OMAP5 support.  The latter will depend on all the OMAP5
data/headers but the cleanup/consolidation stuff could be merged sooner
(but probably a bit late for v3.10 now.)

Kevin
