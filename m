From: vikram186@gmail.com (Vikram Narayanan)
Date: Wed, 20 Apr 2011 23:45:14 +0530
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
Message-ID: <BANLkTi=q8-1ybXNky04A6WA7+VA5ZgOB-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am developing a BSP for a ARM Cortex-M3 (no MMU) based board. In
order to have tickless kernel and deferrable timers, what are the
architecture specific implementations. Can some one point out some
examples that already have this feature enabled and also in the kernel
tree.

And also, are clocksoure and clockevents dependent on each other? I
see in some platforms, that they have used 2 different timers for the
above. Can a same clock be used for both clocksource and clockevents?
Please throw some light on this. If it can be used so, what ties up
the clocksource and clockevent?

NOTE: As cortex-M3 doesn't have an MMU I should be using uClinux.
Since my question is very much relevant to ARM I am posting it here.

-
Vikram
