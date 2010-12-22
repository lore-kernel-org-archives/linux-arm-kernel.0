From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 22 Dec 2010 10:59:18 +0000
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <20101222105918.GA2838@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 11:32:23AM +0000, Russell King - ARM Linux wrote:
> Here is the entire set of clocksource and sched_clock patches which
> have been previously posted.  There's a couple of small tweaks in a
> few of the patches (such as adding notrace to OMAP clocksource read
> functions), and this also shows the proper ordering of these patches.
> 
> Still looking for acks or tested-by's for these patches.

Don't know if it helps, but I've tested the core patches on my picoxcell 
series with the fixed versions and it works nicely.

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie
