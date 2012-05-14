From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 20:03:27 +0000
Subject: [GIT PULL] Samsung boards update for v3.5
In-Reply-To: <4FAF0326.8000408@samsung.com>
References: <4FAF0326.8000408@samsung.com>
Message-ID: <201205142003.27537.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 May 2012, Kukjin Kim wrote:
> Hi Arnd, Olof,
> 
> Please pull Samsung boards update for v3.5.
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> next/board-samsung
> 
> As there were discussions, some exynos4 boards have been updated because 
> current dt cannot support all features for current board files on exynos4.
> 
> Note, this should be merged after next/devel-samsung because some 
> platform devices are defined in that.
> 
> If any problems, please let me know.

Pulled into next/boards now.

Since we have not pulled the next/devel-samsung branch yet, and that branch
depends on the sysmmu branch, the dependencies won't easily get fulfilled.
A test build of exynos4_defconfig showed that there is at least no build
time problem.

What is the dependency you are referring to?

	Arnd
