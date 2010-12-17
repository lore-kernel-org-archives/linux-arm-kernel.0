From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 11:32:23 +0000
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Message-ID: <20101217113223.GC9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the entire set of clocksource and sched_clock patches which
have been previously posted.  There's a couple of small tweaks in a
few of the patches (such as adding notrace to OMAP clocksource read
functions), and this also shows the proper ordering of these patches.

Still looking for acks or tested-by's for these patches.
