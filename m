From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 26 Jul 2013 13:25:42 -0700
Subject: [PATCH v3 0/3] ARM: bcm281xx: GPIO driver
Message-ID: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the GPIO driver, and its device tree bindings,
for the Broadcom bcm281xx family of chips.

Markus Mayer (3):
  ARM: bcm281xx: Add GPIO driver
  ARM: bcm281xx: Device Tree bindings for GPIO driver
  ARM: bcm281xx: Enable GPIO driver

 .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   41 ++
 arch/arm/boot/dts/bcm11351.dtsi                    |   16 +
 arch/arm/mach-bcm/Kconfig                          |    2 +-
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-bcm-kona.c                       |  697 ++++++++++++++++++++
 6 files changed, 762 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
 create mode 100644 drivers/gpio/gpio-bcm-kona.c

-- 
1.7.9.5
