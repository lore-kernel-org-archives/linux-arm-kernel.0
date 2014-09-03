From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  3 Sep 2014 11:27:56 +0100
Subject: [PATCH 0/3] Add picoPHY usb phy driver found on stih407 family SoC's
Message-ID: <1409740079-16554-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the picoPHY usb phy which is used by the usb2
and usb3 host controllers when controlling usb2/1.1 devices. It is found on
stih407 family SoC's from the consumer electronics devision of STMicroelectronics.

Peter Griffin (3):
  phy: phy-stih407-usb: Add usb picoPHY driver found on stih407 SoC
    family
  phy: phy-stih407-usb: Add dt documentation for USB picophy found on
    stih407 SoC family
  MAINTAINERS: Add phy-stih407-usb.c file to ARCH/STI architecture

 .../devicetree/bindings/phy/phy-stih407-usb.txt    |  37 +++++
 MAINTAINERS                                        |   1 +
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-stih407-usb.c                      | 185 +++++++++++++++++++++
 5 files changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stih407-usb.txt
 create mode 100644 drivers/phy/phy-stih407-usb.c

-- 
1.9.1
