From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri,  4 Jul 2014 12:13:49 +0100
Subject: [PATCH 0/3]  Add ST dwc3 glue layer driver.
Message-ID: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the ST glue logic to manage the DWC3 HC
on STiH407 SoC family chipsets.

Peter Griffin (3):
  usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
  ARM: dts: sti: Add st-dwc3 devicetree bindings documentation
  MAINTAINERS: Add dwc3-st.c file to ARCH/STI architecture

 Documentation/devicetree/bindings/usb/dwc3-st.txt |  58 ++++
 MAINTAINERS                                       |   1 +
 drivers/usb/dwc3/Kconfig                          |   9 +
 drivers/usb/dwc3/Makefile                         |   1 +
 drivers/usb/dwc3/dwc3-st.c                        | 325 ++++++++++++++++++++++
 5 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-st.txt
 create mode 100644 drivers/usb/dwc3/dwc3-st.c

-- 
1.9.1
