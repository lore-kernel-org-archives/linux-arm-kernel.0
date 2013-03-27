From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Mar 2013 23:21:36 +0530
Subject: [PATCH 0/5] arm: arch_timer cleanups and niceties for 3.10
In-Reply-To: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
References: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
Message-ID: <515331A8.3080101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Wednesday 27 March 2013 10:41 PM, Mark Rutland wrote:
> The following patches clean up some (harmless) fallout from the changes
> in 3.9, and make the driver always use the virtual counter, eliminating
> problems relating to choosing which counters to use (racy
> initialisation, branches in hot paths).
> 
> The patches are based on  v3.9-rc4, and have been tested on a TC2 with
> KVM.
> 
> The patches can also be found in my public git tree:
> git://linux-arm.org/git/linux-mr.git clocks/arch-timer-cleanups
> 
> Rob, patch 3 "clocksource: arch_timer: use virtual counters" clashes
> with your CLKSRC_OF patches, but only by the fact nearby lines are
> alterered. The resolution is trivial and I'm happy to rebase this series
> as necessary.
> 
After scanning the patches, most of them I see as fixes rather than
clean-up. Patches as such looks fine to me.
FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
