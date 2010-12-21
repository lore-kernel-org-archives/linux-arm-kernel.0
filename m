From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 21 Dec 2010 11:24:30 -0800
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 17 Dec 2010 11:32:23 +0000")
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <87pqsvx72p.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Here is the entire set of clocksource and sched_clock patches which
> have been previously posted.  There's a couple of small tweaks in a
> few of the patches (such as adding notrace to OMAP clocksource read
> functions), and this also shows the proper ordering of these patches.
>
> Still looking for acks or tested-by's for these patches.

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

on a few davinci platforms.

Kevin
