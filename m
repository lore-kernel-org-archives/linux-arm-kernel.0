From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 30 Aug 2013 10:15:11 -0700
Subject: [PATCH v7 0/3] gpio: bcm281xx: GPIO driver
Message-ID: <1377882914-30152-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the GPIO driver, and its device tree bindings,
for the Broadcom bcm281xx family of mobile SoCs.

Changes since v6:
- Broke out arch/arm/mach-bcm/Kconfig into its own patch
- Changed commit title messages accordingly

Markus Mayer (3):
  gpio: bcm281xx: Add GPIO driver
  ARM: bcm281xx: Enable GPIO driver
  ARM: bcm281xx: Add device node for the GPIO controller

 .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   52 ++
 arch/arm/boot/dts/bcm11351.dtsi                    |   16 +
 arch/arm/mach-bcm/Kconfig                          |    2 +-
 drivers/gpio/Kconfig                               |    5 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-bcm-kona.c                       |  631 ++++++++++++++++++++
 6 files changed, 706 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
 create mode 100644 drivers/gpio/gpio-bcm-kona.c

-- 
1.7.9.5
