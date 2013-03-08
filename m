From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 8 Mar 2013 18:30:39 +0100
Subject: [PATCH 0/3] dt and pinctrl support for at91_can
Message-ID: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This set of patches add device tree and pinctrl support to the at91_can driver.

Regards


Ludovic Desroches (3):
  can: at91_can: add dt support
  can: at91_can: add pinctrl support
  can: Kconfig: CAN_AT91 depends on ARCH_AT91

 .../devicetree/bindings/net/can/atmel-can.txt      | 14 ++++
 drivers/net/can/Kconfig                            |  2 +-
 drivers/net/can/at91_can.c                         | 84 +++++++++++++++++-----
 3 files changed, 80 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt

-- 
1.7.11.3
