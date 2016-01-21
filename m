From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:33 -0800
Subject: [GIT PULL 0/9] ARM: SoC updates for v4.5
Message-ID: <1453338882-31300-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's our batch of changes for v4.5. A little later than usual, life has been
a bit on the busy side lately.

Biggest news this cycle is the conversion of the remaining long tail ARMv6/v7
platforms to multiplatform, the culmination of 5 years worth of work. Details
are in the 3rd pull request.

Beyond that it's the usual mix of some new SoCs and platforms, new
hardware support, a few driver additions and updates and various tweaks
and fixes.

No hairy conflicts this time around, mostly a few add/add trivial updates.

I did notice that you picked up a conflicting MAINTAINERS update for
Renesas platforms this morning (after I had generated these emails and
checked for conflicts), but it shouldn't be bad to sort out.


Please merge!  

Thanks,

-Olof
