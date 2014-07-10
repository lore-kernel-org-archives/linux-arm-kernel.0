From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 10 Jul 2014 16:18:03 +0100
Subject: [PATCH 0/3] Add USB HCD support for STi SoCs
Message-ID: <1405005486-26355-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver adds support for the USB HCD controller present in STi
SoC's from STMicroelectronics. It has been tested on the stih416-b2020
board.

The original author is no longer with the company and therefore emails
to his address bounce, thus I have not added him to CC.

Peter Griffin (3):
  usb: host: st-hcd: Add USB HCD support for STi SoCs
  usb: host: st-hcd: Add st-hcd devicetree bindings documentation.
  MAINTAINERS: Add st-hcd to ARCH/STI architecture

 Documentation/devicetree/bindings/usb/st-hcd.txt |  51 +++
 MAINTAINERS                                      |   1 +
 drivers/usb/host/Kconfig                         |  17 +
 drivers/usb/host/Makefile                        |   1 +
 drivers/usb/host/st-hcd.c                        | 471 +++++++++++++++++++++++
 5 files changed, 541 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/st-hcd.txt
 create mode 100644 drivers/usb/host/st-hcd.c

-- 
1.9.1
