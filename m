From: hatim.rv@samsung.com (Hatim Ali)
Date: Wed, 21 Sep 2011 11:14:17 +0530
Subject: [PATCH V2 0/3] Add TVOUT support for SMDKV310
Message-ID: <1316583860-32510-1-git-send-email-hatim.rv@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of the TVOUT patch set for SMDKV310.
v1 is available at below link.
(http://www.spinics.net/lists/arm-kernel/msg138054.html)

Patch 1 has been modified according to the comments received from
Tomasz Stanislawski.
Patches 2 and 3 are RESENDs.

Hatim Ali (3):
  ARM: EXYNOS4: Add TVOUT support for SMDKV310
  ARM: EXYNOS4: Update consistent DMA size to 8MB
  s5p-tv: Add PM_RUNTIME dependency

 arch/arm/mach-exynos4/Kconfig               |    2 ++
 arch/arm/mach-exynos4/include/mach/memory.h |    2 ++
 arch/arm/mach-exynos4/mach-smdkv310.c       |   25 +++++++++++++++++++++++++
 drivers/media/video/s5p-tv/Kconfig          |    2 +-
 4 files changed, 30 insertions(+), 1 deletions(-)

-- 
1.7.2.3
