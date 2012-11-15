From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 17:46:34 +0000
Subject: [arm-soc:for-next 24/32]
 arch/arm/mach-omap2/board-generic.c:115:13: error: 'omap_prcm_restart'
 undeclared here (not in a function)
In-Reply-To: <50a52344.hTPnPrYFuOqQEPAJ%fengguang.wu@intel.com>
References: <50a52344.hTPnPrYFuOqQEPAJ%fengguang.wu@intel.com>
Message-ID: <201211151746.34478.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
> head:   85f1e7156cfb396d46327b9e6cdf4dbf576f3bcc
> commit: 3b7b5ae34c4604e6a1e0724fc8bd60e44f07e1ef [24/32] Merge branch 'next/dt' into for-next
> config: make ARCH=arm omap2plus_defconfig
> 
> Note: the arm-soc/for-next HEAD 85f1e71 builds fine.
>       It only hurts bisectibility.
> 
> All error/warnings:
> 
> arch/arm/mach-omap2/board-generic.c:115:13: error: 'omap_prcm_restart' undeclared here (not in a function)
> 
> vim +115 +/omap_prcm_restart arch/arm/mach-omap2/board-generic.c
> 

Thanks for the fast report!

Not quite fast enough this time, I found the same problem 20 minutes
earlier and immediately fixed it already ;-)

Tony also reported this one already.

	Arnd
