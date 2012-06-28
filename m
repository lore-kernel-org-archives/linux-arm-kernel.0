From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 29 Jun 2012 08:39:44 +0900
Subject: [GIT PULL] Samsung fixes-1 for v3.5
Message-ID: <02c401cd5587$4bbff670$e33fe350$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull Samsung fixes for v3.5 from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.5-samsung-fixes-1

These are small fixes for wrong address, config and clk check.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.5-samsung-fixes-1

Jonghwan Choi (1):
      ARM: SAMSUNG: Should check for IS_ERR(clk) instead of NULL

Jose Miguel Goncalves (1):
      ARM: SAMSUNG: Fix for S3C2412 EBI memory mapping

Sachin Kamat (1):
      ARM: EXYNOS: Fix EXYNOS_DEV_DMA Kconfig entry

 arch/arm/mach-exynos/Kconfig                       |    8 ++++----
 arch/arm/plat-samsung/include/plat/map-s3c.h       |    2 +-
 .../arm/plat-samsung/include/plat/watchdog-reset.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)
