From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue,  8 Sep 2015 22:38:03 +0200
Subject: [PATCH v2 0/3] ARMv7-M: Make FORCE_MAX_ZONE_ORDER configurable from
 defconfig
Message-ID: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes possible to set MAX_ZONE_ORDER from defconfig for ARMv7-M
platforms when build as single platform.

It sets the FORCE_MAX_ZONE_ORDER value to 9 for STM32 and EFM32 for
consistency for the later, as it was the case before this series.

Maxime Coquelin (3):
  ARM: Make FORCE_MAX_ZONEORDER configurable if ARM_SINGLE_ARMV7M
  ARM: configs: Set FORCE_MAX_ZONE_ORDER to 9 in stm32_defconfig
  ARM: configs: Set FORCE_MAX_ZONEORDER to 9 in efm32_defconfig

 arch/arm/Kconfig                 | 4 ++--
 arch/arm/configs/efm32_defconfig | 1 +
 arch/arm/configs/stm32_defconfig | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.1
