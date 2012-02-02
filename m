From: khilman@ti.com (Kevin Hilman)
Date: Thu, 02 Feb 2012 10:38:31 -0800
Subject: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
In-Reply-To: <20120202093600.12509.35052.stgit@dusk> (Paul Walmsley's message
 of "Thu, 02 Feb 2012 02:38:48 -0700")
References: <20120202093600.12509.35052.stgit@dusk>
Message-ID: <87ty39cc7s.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi
>
> This series consolidates some duplicated PM code across OMAP2, 3, and 4.
> This saves both binary kernel image size, and lines of source.  These
> functions are just the low-hanging fruit; it looks to me like there's even
> more consolidation that could be done.
>
> Suspend + UART wakeup was tested on OMAP44xx BeagleBoard.  

I assume you meant Panda board?

> On the OMAP35xx Beagleboard here, v3.3-rc2 doesn't seem to wake up
> from suspend correctly with or without these patches, so I've only
> boot-tested them on that platform.

I also tested idle & suspend + UART wakeup on 3430/n900, 3530/Overo.

Will add these to my cleanup queue for v3.4[1] after adding a Tested-by
from Santosh.

Kevin

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/cleanup/pm
