From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 13:15:57 +0100
Subject: [GIT PULL 3/5] Samsung defconfig update for v3.19
In-Reply-To: <546F491B.4020709@kernel.org>
References: <546F491B.4020709@kernel.org>
Message-ID: <201411281315.57712.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014, Kukjin Kim wrote:
> The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:
> 
>   Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-defconfig-v3.19
> 
> for you to fetch changes up to 26048def56ac2f901d4245d2935c797984e96d68:
> 
>   ARM: exynos_defconfig: Use 16 minors per MMC block device (2014-11-21
> 22:04:05 +0900)
> 
> ----------------------------------------------------------------
> Samsung defconfig update for v3.19
> 
> - Use 16 minors per MMC block device for exynos_defconfig
>   : 16 minors per MMC block device are required for Rinato (Gear 2)
> 


The defconfig branch didn't have v3.18-rc3 yet, so I cherry-picked the
one patch from this branch to avoid a back-merge from upstream.

Please make sure to base patches on older -rc releases if you can,
it makes our lives easier.

Thanks!

	Arnd
