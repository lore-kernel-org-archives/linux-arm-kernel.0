From: carlo@caione.org (Carlo Caione)
Date: Sat,  8 Feb 2014 17:03:45 +0100
Subject: [PATCH 0/3] mfd: axp20x: Add support for PMIC axp202 and axp209
Message-ID: <1391875428-6281-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches add prelinary support for PMIC X-Powers axp202 and axp209.
Only two subsystem are supported at the moment: power enable key (PEK) and
regulators. Drivers for these two sub-system will be submitted in later
patch-sets.

Carlo Caione (3):
  mfd: axp20x: Add mfd driver for axp20x PMIC
  mfd: axp20x: Add dtsi for axp20x
  mfd: axp20x: Add bindings documentation

 Documentation/devicetree/bindings/mfd/axp20x.txt |  87 ++++++++
 arch/arm/boot/dts/axp20x.dtsi                    |   9 +
 drivers/mfd/Kconfig                              |  12 ++
 drivers/mfd/Makefile                             |   1 +
 drivers/mfd/axp20x.c                             | 251 +++++++++++++++++++++++
 include/linux/mfd/axp20x.h                       | 178 ++++++++++++++++
 6 files changed, 538 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
 create mode 100644 arch/arm/boot/dts/axp20x.dtsi
 create mode 100644 drivers/mfd/axp20x.c
 create mode 100644 include/linux/mfd/axp20x.h

-- 
1.8.5.3
