From: tony@atomide.com (Tony Lindgren)
Date: Sun, 16 Dec 2012 12:05:34 -0800
Subject: [PATCH 1/2] ARM: OMAP2+: Drop remaining plat/cpu.h usage where
 possible
In-Reply-To: <20121214194450.9874.57095.stgit@muffinssi.local>
References: <20121214194325.9874.95898.stgit@muffinssi.local>
 <20121214194450.9874.57095.stgit@muffinssi.local>
Message-ID: <20121216200533.GQ4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121214 11:47]:
> These macros are now in local soc.h in arch/arm/mach-omap2,
> and plat/cpu.h is around only until the remaining drivers
> are fixed.
> 
> Also remove the unused plat/cpu.h from smartreflex.c as it
> will cause compile errors with ARCH_MULTIPLATFORM enabled.

Looks like we can remove it completely, so posted an updated
patch.

Tony
