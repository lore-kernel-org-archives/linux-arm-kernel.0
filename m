From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 15 Jun 2015 18:38:03 +0200
Subject: [PATCH linux-next 0/2] mfd: flexcom: add a driver for Flexcom
Message-ID: <cover.1434386119.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ChangeLog

v1:
This series of patches a support to the Atmel Flexcom, a wrapper which
integrates an USART, a SPI controller and a TWI controller. Only one
peripheral can be used at a time. The active function is selected though
the Flexcom Mode Register.

Cyrille Pitchen (2):
  mfd: devicetree: add bindings for Atmel Flexcom
  mfd: flexcom: add a driver for Atmel Flexible Serial Communication
    Unit

 .../devicetree/bindings/mfd/atmel-flexcom.txt      | 28 +++++++
 drivers/mfd/Kconfig                                | 11 +++
 drivers/mfd/Makefile                               |  1 +
 drivers/mfd/atmel-flexcom.c                        | 97 ++++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
 create mode 100644 drivers/mfd/atmel-flexcom.c

-- 
1.8.2.2
