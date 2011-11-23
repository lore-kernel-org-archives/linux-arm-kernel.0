From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Nov 2011 21:15:17 +0000
Subject: [GIT PULL] Samsung fixes for v3.2
In-Reply-To: <03e501cca837$d893e320$89bba960$%kim@samsung.com>
References: <03e501cca837$d893e320$89bba960$%kim@samsung.com>
Message-ID: <201111232115.18048.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2011, Kukjin Kim wrote:
> Please pull samsung-fixes for v3.2 from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> samsung-fixes
> 
> This includes fix of inclusion header.
> If any problems, please let me know.
> 

Pulled, thanks!

On Monday 21 November 2011, Kyungmin Park wrote:
> Don't you fix the mct compiler error if LOCAL_TIMERS are not defined?
> 
> arch/arm/mach-exynos/mct.c: In function 'exynos4_timer_resources':
> arch/arm/mach-exynos/mct.c:451: error: 'exynos4_mct_tick_isr'
> undeclared (first use in this function)
> arch/arm/mach-exynos/mct.c:451: error: (Each undeclared identifier is
> reported only once
> arch/arm/mach-exynos/mct.c:451: error: for each function it appears in.)
> make[1]: *** [arch/arm/mach-exynos/mct.o] Error 1

Has a patch been posted for this?

	Arnd
