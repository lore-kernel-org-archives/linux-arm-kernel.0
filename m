From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 25 Jan 2012 15:23:21 +0100
Subject: [PATCH 0/6] ARM: SAMSUNG: Board updates and minor fixes
Message-ID: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series adds S5K6AAFX sensor support on Nuri and 
UNIVERSAL_C210 boards. It also includes minor correction for the I2C
controller setup and the M-5MOLS sensor. 


Sylwester Nawrocki (6):
  ARM: SAMSUNG: Increase virtual framebuffer size on Universal C210 board
  ARM: SAMSUNG: Add support for S5K6AAFX image sensor on Universal C210 board
  ARM: SAMSUNG: Add support for S5K6AAFX camera on Nuri board
  ARM: SAMSUNG: Correct framebuffer window size on Nuri board
  ARM: SAMSUNG: Correct M-5MOLS sensor clock frequency on Nuri board
  ARM: SAMSUNG: Fix platform data setup for I2C adapter 0

 arch/arm/mach-exynos/Kconfig               |    2 +
 arch/arm/mach-exynos/mach-nuri.c           |   73 ++++++++++++++++++++++++--
 arch/arm/mach-exynos/mach-universal_c210.c |   78 ++++++++++++++++++++++++++--
 arch/arm/plat-samsung/devs.c               |    4 +-
 4 files changed, 147 insertions(+), 10 deletions(-)

-- 
1.7.8.3
