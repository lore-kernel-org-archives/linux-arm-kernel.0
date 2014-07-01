From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  1 Jul 2014 15:30:44 +0100
Subject: [PATCH 0/3] Add reset controllers for STiH407 SoC
Message-ID: <1404225047-9495-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds reset controller support for the STiH407 SoC.

Peter Griffin (3):
  drivers: reset: stih407: Add softreset, powerdown and picophy
    controllers
  ARM: sti: Add STiH407 Kconfig entry to select STIH407_RESET
  ARM: STi: STiH407: Add reset controller support.

 .../bindings/reset/st,sti-picophyreset.txt         |  41 ++++++
 arch/arm/boot/dts/stih407.dtsi                     |  16 +++
 arch/arm/mach-sti/Kconfig                          |  10 ++
 drivers/reset/sti/Kconfig                          |   4 +
 drivers/reset/sti/Makefile                         |   1 +
 drivers/reset/sti/reset-stih407.c                  | 159 +++++++++++++++++++++
 .../dt-bindings/reset-controller/stih407-resets.h  |  60 ++++++++
 7 files changed, 291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
 create mode 100644 drivers/reset/sti/reset-stih407.c
 create mode 100644 include/dt-bindings/reset-controller/stih407-resets.h

-- 
1.9.1
