From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Mar 2011 09:54:23 -0800
Subject: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of
	individual hwmods
In-Reply-To: <4D6B845A.9000900@ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<4D651998.3040002@ti.com>
	<alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com>
	<4D6B845A.9000900@ti.com>
Message-ID: <20110302175422.GY20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 2/28/2011 3:31 AM, Paul Walmsley wrote:
> >Tony, I guess the omap-for-linus branch will probably need to get rebuilt
> >to drop that patch, once this series is merged...

Let's rather apply a fix or revert instead than start messing with
omap-for-linus. That branch is supposed to be a stable base for others
to base their branches on.

Tony
