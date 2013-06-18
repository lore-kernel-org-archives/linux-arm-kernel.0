From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Jun 2013 04:59:59 +0900
Subject: [GIT PULL 02/10] Samsung EXYNOS arch for v3.11
Message-ID: <51C0BC3F.2060002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-arch-2

for you to fetch changes up to b5f3c75a75d31039c6de3ab38d074b43c60462f7:

   ARM: EXYNOS: call scu_enable() only in case of cortex-A9 processor 
(2013-06-19 03:41:38 +0900)

----------------------------------------------------------------
arch/arm/mach-exynos update
- enable XHCI on exynos5
- enable Pinctrl on exynos4 and exynos5
- calling scu_enable() is only available on Cortex-A9

----------------------------------------------------------------
Doug Anderson (1):
       ARM: EXYNOS: Select PINCTRL_EXYNOS for exynos4/5 at chip level

Leela Krishna Amudala (1):
       ARM: EXYNOS: call scu_enable() only in case of cortex-A9 processor

Vivek Gautam (1):
       ARM: EXYNOS: Enable XHCI support on exynos5

  arch/arm/mach-exynos/Kconfig   | 10 +++++++---
  arch/arm/mach-exynos/platsmp.c |  2 +-
  drivers/pinctrl/Kconfig        |  5 +++--
  3 files changed, 11 insertions(+), 6 deletions(-)
