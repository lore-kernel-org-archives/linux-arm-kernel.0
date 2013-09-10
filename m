From: markus.mayer@linaro.org (Markus Mayer)
Date: Tue, 10 Sep 2013 11:07:00 -0700
Subject: [PATCH v9 0/3] gpio: bcm281xx: GPIO driver
Message-ID: <1378836423-12467-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the GPIO driver, and its device tree bindings,
for the Broadcom bcm281xx family of mobile SoCs.

Changes since v8:
- rebased SHA 26b0332e30c7f93e780aaa054bd84e3437f84354
  (so it'll apply against 3.12-rc1)
As a result:
- patch context in patch 2/3 changed by automatic merge
- patch context in patch 3/3 changed by manual merge

Markus Mayer (3):
  gpio: bcm281xx: Add GPIO driver
  ARM: bcm281xx: Enable GPIO driver
  ARM: bcm281xx: Add device node for the GPIO controller

 .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   52 ++
 arch/arm/boot/dts/bcm11351.dtsi                    |   16 +
 arch/arm/mach-bcm/Kconfig                          |    2 +-
 drivers/gpio/Kconfig                               |    5 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-bcm-kona.c                       |  632 ++++++++++++++++++++
 6 files changed, 707 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
 create mode 100644 drivers/gpio/gpio-bcm-kona.c

-- 
1.7.9.5
