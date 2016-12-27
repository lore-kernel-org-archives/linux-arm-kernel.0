From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Dec 2016 13:05:27 +0100
Subject: [PATCH 0/3] MPU-3050 defconfig updates
Message-ID: <20161227120530.31190-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are three defconfig patches to the ARM SoC tree that replace
the use of the partial input driver for MPU-3050 with the fully featured
IIO replacement driver.

Please apply these directly for defconfig updates post-v4.10-rc1.

Linus Walleij (3):
  ARM: defconfig: replace MPU3050 driver on multi_v7
  ARM: defconfig: tegra: switch to MPU3050 IIO driver
  ARM: defconfig: pxa: cut MPU3050 input driver

 arch/arm/configs/multi_v7_defconfig | 4 +++-
 arch/arm/configs/pxa_defconfig      | 1 -
 arch/arm/configs/tegra_defconfig    | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.9.3
