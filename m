From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 21 Nov 2014 23:15:55 +0900
Subject: [GIT PULL 3/5] Samsung defconfig update for v3.19
Message-ID: <546F491B.4020709@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:

  Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig-v3.19

for you to fetch changes up to 26048def56ac2f901d4245d2935c797984e96d68:

  ARM: exynos_defconfig: Use 16 minors per MMC block device (2014-11-21
22:04:05 +0900)

----------------------------------------------------------------
Samsung defconfig update for v3.19

- Use 16 minors per MMC block device for exynos_defconfig
  : 16 minors per MMC block device are required for Rinato (Gear 2)

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Use 16 minors per MMC block device

 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)
