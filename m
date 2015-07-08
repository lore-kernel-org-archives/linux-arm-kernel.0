From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  8 Jul 2015 16:09:19 +0200
Subject: [PATCH 0/2] ARM: mvebu: clear shared L2 bit on Armada XP
Message-ID: <1436364561-20958-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of two patches add support for clearing the shared L2 bit on
Marvell Armada XP. This is part of an effort to progressively close
the gap between Marvell's vendor BSP and the mainline kernel.

Best regards,

Thomas

Thomas Petazzoni (2):
  ARM: mvebu: add support to clear shared L2 bit on Armada XP
  ARM: mvebu: add CPU config registers in the Armada 370/XP Device Tree

 .../devicetree/bindings/arm/mvebu-cpu-config.txt   | 20 +++++++
 arch/arm/boot/dts/armada-370.dtsi                  |  5 ++
 arch/arm/boot/dts/armada-xp.dtsi                   |  5 ++
 arch/arm/mach-mvebu/coherency.c                    | 61 ++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mvebu-cpu-config.txt

-- 
2.4.5
