From: markus.mayer@linaro.org (Markus Mayer)
Date: Thu, 29 Aug 2013 16:51:05 -0700
Subject: [PATCH v6 0/2] gpio: bcm281xx: GPIO driver
Message-ID: <1377820267-20050-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the GPIO driver, and its device tree bindings,
for the Broadcom bcm281xx family of mobile SoCs.

Changes since v5:

- Folded former patch 2/3 into patch 1 (so now there's only 2 patches)
- Changed the subject lines of the series from "ARM: ..." to "gpio: ..."
- Added a more detailed description to the commit message in patch 1
- Slightly edited the commit message in patch 2 to match
- No changes to the code

Markus Mayer (2):
  gpio: bcm281xx: Add GPIO driver
  gpio: bcm281xx: Add device node for the GPIO controller

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
