From: anders.berg@avagotech.com (Anders Berg)
Date: Mon,  1 Sep 2014 14:53:39 +0200
Subject: [PATCH 0/2] Add driver for AXM55xx SSP chip selects
Message-ID: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver enables control of the SSP/SPI chip-select signals as GPIOs on the
AXM55xx device.

Anders Berg (2):
  gpio: Add driver for AXM55xx SSP chip selects
  Documentation: DT bindings for AXM55xx SSP CS

 .../devicetree/bindings/gpio/gpio-axxia-sspcs.txt  |  36 ++++++
 drivers/gpio/Kconfig                               |   8 ++
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-axxia-ssp.c                      | 128 +++++++++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-axxia-sspcs.txt
 create mode 100644 drivers/gpio/gpio-axxia-ssp.c

-- 
1.9.1
