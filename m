From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Aug 2017 20:38:44 -0500
Subject: [PATCH 2/3] ARM: OMAP5: Add cpuidle assembly code
In-Reply-To: <20170817230122.30655-3-tony@atomide.com>
References: <20170817230122.30655-1-tony@atomide.com>
 <20170817230122.30655-3-tony@atomide.com>
Message-ID: <97a05a99-3fc5-7fb8-f6d0-708c5d0ddcdc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2017 06:01 PM, Tony Lindgren wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> In order to support CPU off modes during idle like omap4 already
> does, we need to add the assembly code needed for restoring the
> CPU state from off mode.
> 
> The code is a combination of the following earlier patches done
> by Santosh Shilimkar <santosh.shilimkar@oracle.com> in TI Linux
> kernel tree:
> 
> 881603c3f97f ("ARM: OMAP5: PM: Add CPU power off mode support")
> 411533444365 ("ARM: OMAP5: PM: Add MPU Open Switch Retention support")
> 3f9ea63594c3 ("ARM: OMAP5: PM: Add L2 memory power down support")

Ref: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f5dc91b691cf296c49aedf0a671fd659a70f737 
and the fact that OSWR and OFF both have been descoped in production 
silicon, is again the reason why TI has not posted these preproduction 
experimentation patches upstream.

NAK once again. Sorry.

PS: deleting Santosh's old TI ID which should unfortunately be 
bouncing now.

-- 
Regards,
Nishanth Menon
