From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Dec 2010 16:03:19 -0000
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <000a01cb9e03$ed0ace70$c7206b50$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> Here is the entire set of clocksource and sched_clock patches which
> have been previously posted.  There's a couple of small tweaks in a
> few of the patches (such as adding notrace to OMAP clocksource read
> functions), and this also shows the proper ordering of these patches.
> 
> Still looking for acks or tested-by's for these patches.

I took these for a spin on my Versatile Express board and it seems
happy enough doing parallel builds with all the CPUs fully loaded.

Tested-by: Will Deacon <will.deacon@arm.com>

I don't think these conflict with the multi-tile patch I sent to the
patch system, but if you see a conflict please let me know.

Will
