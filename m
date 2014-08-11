From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 11 Aug 2014 11:09:09 +0100
Subject: [PATCH v2 0/3] Add usb phy support for STiH41x SoCs.
Message-ID: <1407751752-32383-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the on-chip PHY used for USB 1.1 and 2.0 found
on STiH415 and STiH416 consumer electronics SoC's from STMicroelectronics.

Changes since v1:
 - Change to select GENERIC_PHY rather than depends for uniformity
 - Ensure phy_provider_register is called  after PHY is created
 - Add extra commit message for MAINTAINERS patch

Peter Griffin (3):
  phy: phy-stih41x-usb: Add usb phy support for STiH41x SoCs.
  phy: phy-stih41x-usb: Add dt documentation for USB phy on STiH415/6
  MAINTAINERS: Add phy-stih41x-usb.c to ARCH/STI architecture

 .../devicetree/bindings/phy/phy-stih41x-usb.txt    |  24 +++
 MAINTAINERS                                        |   1 +
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-stih41x-usb.c                      | 187 +++++++++++++++++++++
 5 files changed, 221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
 create mode 100644 drivers/phy/phy-stih41x-usb.c

-- 
1.9.1
