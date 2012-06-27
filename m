From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Jun 2012 04:55:39 -0700
Subject: [GIT PULL] OMAP3 PM: preformance enhancements
In-Reply-To: <87obo6dz15.fsf@ti.com>
References: <87obo6dz15.fsf@ti.com>
Message-ID: <20120627115538.GE3483@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120626 05:47]:
> Tony,
> 
> Please pull the following PM/performance enhancements for v3.6.  I
> recently rebased it on your devel-pm branch to avoid some conflicts
> with the IO chain stuff recently merged from Paul.
> 
> This series had the goal of improving the responsiveness of the
> shallowest idle states.  Several reports came in that even when only
> hitting the shallowest idle states, there was a significant performance
> hit.  This series addresses the major sources of latency in the
> shallowest idle states.

OK, pulling into devel-pm.

Tony
