From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Mar 2012 11:39:36 +0100
Subject: [PATCHv2 0/3] Add support for DRM display subsystem
Message-ID: <1331635180-7207-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set adds support for Exynos DRM display subsystem for
Universal C210 and NURI boards. Exynos DRM driver has been merged to 3.3
kernel tree and provides unified and more powerful alternative for
s3c-fb and s5p-tv drivers. V2 includes update for the latest changes in
platform data structure (added 'panel' entry).

Best regards

Marek Szyprowski
Samsung Poland R&D Center

Patch summary:

Marek Szyprowski (3):
  ARM: Exynos: add platform device for core DRM subsystem
  ARM: Exynos: Add DRM core device support for Universal C210 board
  ARM: Exynos: Add DRM core support for NURI board

 arch/arm/mach-exynos/Kconfig               |    7 ++++++
 arch/arm/mach-exynos/Makefile              |    1 +
 arch/arm/mach-exynos/dev-drm.c             |   29 ++++++++++++++++++++++++
 arch/arm/mach-exynos/mach-nuri.c           |   33 ++++++++++++++++++++++++++++
 arch/arm/mach-exynos/mach-universal_c210.c |   33 ++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h  |    2 +
 6 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos/dev-drm.c

-- 
1.7.1.569.g6f426
