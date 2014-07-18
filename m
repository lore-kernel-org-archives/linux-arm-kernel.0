From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 19 Jul 2014 08:34:59 +0900
Subject: [GIT PULL] Samsung fixes-4 for v3.16
Message-ID: <53C9AF23.6030007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a regression for v3.16 so please take this in -rc.

Thanks,
Kukjin

The following changes since commit 1795cd9b3a91d4b5473c97f491d63892442212ab:

   Linux 3.16-rc5 (2014-07-13 14:04:33 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-4

for you to fetch changes up to 4e3a498d6fc438d8c203c51aadc6ca8fb47b0577:

   ARM: EXYNOS: Fix core ID used by platsmp and hotplug code (2014-07-16 
02:59:18 +0900)

----------------------------------------------------------------
Samsung fixes-4 for v3.16
- Fix core ID for platsmp and hotplug
   This fixes existing calculation of PMU register offsets on
   exynos SoCs and this also fixes CPU hotplug with more than
   2 cores, because it removes incorrect condition check in
   platform_do_lowpower().

----------------------------------------------------------------
Tomasz Figa (1):
       ARM: EXYNOS: Fix core ID used by platsmp and hotplug code

  arch/arm/mach-exynos/hotplug.c | 10 ++++++----
  arch/arm/mach-exynos/platsmp.c | 34 +++++++++++++++++++---------------
  2 files changed, 25 insertions(+), 19 deletions(-)
