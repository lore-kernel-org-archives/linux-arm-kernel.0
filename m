From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 24 Mar 2015 17:17:09 -0700
Subject: [PATCH 0/3] power: reset: BCM63xx reboot support
Message-ID: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for the BCM6328-style software reset hardware
block commonly found on Broadcom BCM63xx DSL SoCs.

Thanks!

Florian Fainelli (3):
  Documentation: bindings: add BCM6328-style soft reset binding
  power: reset: add Broadcom BCM63xx software reset driver
  ARM: dts: BCM63xx: add soft-reset node

 .../devicetree/bindings/arm/bcm/bcm63138.txt       | 16 +++++
 arch/arm/boot/dts/bcm63138.dtsi                    |  5 ++
 drivers/power/reset/Kconfig                        |  7 ++
 drivers/power/reset/Makefile                       |  1 +
 drivers/power/reset/bcm63xx-reboot.c               | 80 ++++++++++++++++++++++
 5 files changed, 109 insertions(+)
 create mode 100644 drivers/power/reset/bcm63xx-reboot.c

-- 
2.1.0
