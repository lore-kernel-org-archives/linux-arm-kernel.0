From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Mar 2013 14:06:26 +0900
Subject: [GIT PULL] Samsung fixes for v3.9
Message-ID: <093101ce1fa8$840c52d0$8c24f870$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is Samsung fixes for v3.9.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.9-samsung-fixes-1

There are two commits for fix pl330 dma clkdev entries on s5pv210 and generic
dma binding support on exynos stuff.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.9-samsung-fixes-1

for you to fetch changes up to 0a96d4d36978c8aeebf5fce1f3041c2d60f23ac0:

  ARM: EXYNOS: Add #dma-cells for generic dma binding support for PL330
(2013-03-07 10:33:07 +0900)

----------------------------------------------------------------
Padmavathi Venna (1):
      ARM: EXYNOS: Add #dma-cells for generic dma binding support for PL330

Sylwester Nawrocki (1):
      ARM: S5PV210: Fix PL330 DMA controller clkdev entries

 arch/arm/boot/dts/exynos4.dtsi    |    9 +++++++++
 arch/arm/boot/dts/exynos5440.dtsi |    6 ++++++
 arch/arm/mach-s5pv210/clock.c     |   36 ++++++++++++++++++------------------
 3 files changed, 33 insertions(+), 18 deletions(-)
