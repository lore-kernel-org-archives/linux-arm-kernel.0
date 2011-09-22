From: hatim.rv@samsung.com (Hatim Ali)
Date: Thu, 22 Sep 2011 11:24:08 +0530
Subject: [PATCH v3 0/2] Add TVOUT support for SMDKV310
Message-ID: <1316670848-1581-1-git-send-email-hatim.rv@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v3 of the TVOUT patch set for SMDKV310.
v1 is available at below link.
(http://www.spinics.net/lists/arm-kernel/msg138054.html)

Patch 1 has been modified according to the comments received from
Tomasz Stanislawski and Sylwester Nawrocki.

Patch 2 is a resend.

NOTE: This patch set has a dependency on "Setup consistent dma size at boot
time" by Tushar Behera.
(http://www.spinics.net/lists/linux-samsung-soc/msg06627.html)

Hatim Ali (2):
  ARM: EXYNOS4: Add TVOUT support for SMDKV310
  s5p-tv: Add PM_RUNTIME dependency

 arch/arm/mach-exynos4/Kconfig         |    2 ++
 arch/arm/mach-exynos4/mach-smdkv310.c |   18 ++++++++++++++++++
 drivers/media/video/s5p-tv/Kconfig    |    2 +-
 3 files changed, 21 insertions(+), 1 deletions(-)

-- 
1.7.2.3
