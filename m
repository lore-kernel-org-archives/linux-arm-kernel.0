From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 13 May 2016 14:26:25 +0300
Subject: [PATCH 0/3] ARM: clps711x: Initial DT support
Message-ID: <1463138788-5390-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series of patches adds initial DT support for Cirrus Logic
ARMv4T processors.

Alexander Shiyan (3):
  ARM: clps711x: Reduce static map size
  ARM: clps711x: Add basic DT support
  ARM: dts: clps711x: Add basic Cirrus Logic CDB89712 Development board

 arch/arm/Kconfig                               |   2 +
 arch/arm/boot/dts/Makefile                     |   2 +
 arch/arm/boot/dts/clps711x-cdb89712.dts        |  56 +++++++
 arch/arm/boot/dts/clps711x.dtsi                | 201 +++++++++++++++++++++++++
 arch/arm/include/debug/clps711x.S              |   4 +-
 arch/arm/mach-clps711x/Kconfig                 |   7 +
 arch/arm/mach-clps711x/common.c                |  20 ++-
 arch/arm/mach-clps711x/devices.c               |   6 +
 arch/arm/mach-clps711x/devices.h               |   1 +
 arch/arm/mach-clps711x/include/mach/hardware.h |   2 +-
 10 files changed, 295 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/clps711x-cdb89712.dts
 create mode 100644 arch/arm/boot/dts/clps711x.dtsi

-- 
2.4.9
