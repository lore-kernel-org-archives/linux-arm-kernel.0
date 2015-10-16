From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 16 Oct 2015 15:04:43 +0200
Subject: [PATCH v2 0/8] Enable several devices for Atmel SAMA5D2
Message-ID: <1445000691-12402-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches enables several devices for the freshly introduced SAMA5D2
SoC. dts and defconfig files are updated to enable SAMA5D2 and its new devices
such as Flexcom and AT91 SDHCI.

Changes:
- v2:
  - update whole Atmel defconfigs
  - update multi_v7_defconfig

Ludovic Desroches (8):
  ARM: at91/dt: sama5d2: add missing devices
  ARM: at91/dt: sama5d2 Xplained: add several devices
  ARM: at91/defconfig: update sama5 defconfig
  ARM: at91/defconfig: update at91_dt defconfig
  ARM: at91/defconfig: add sama5d2 and its new devices to sama5
    defconfig
  ARM: multi_v7_defconfig: Add Atmel SAMA5D2 SoC
  ARM: multi_v7_defconfig: Add Atmel Flexcom device
  ARM: multi_v7_defconfig: Add Atmel SDHCI device

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 106 +++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi              | 152 +++++++++++++++++++++++++++-
 arch/arm/configs/at91_dt_defconfig          |  15 ---
 arch/arm/configs/multi_v7_defconfig         |   3 +
 arch/arm/configs/sama5_defconfig            |  16 ++-
 5 files changed, 265 insertions(+), 27 deletions(-)

-- 
2.5.0
