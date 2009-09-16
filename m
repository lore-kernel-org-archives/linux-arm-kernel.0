From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 16 Sep 2009 11:46:42 +0200
Subject: [PATCH 0/3] at91_can: add support for Atmel's CAN controller on
	AT91SAM9263
Message-ID: <1253094405-3216-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for Atmels's CAN controller as found
on the AT91SAM9263.

Marc Kleine-Budde (3):
      at91sam9263: add at91_can device to generic device definition
      at91sam9263ek: activate at91 CAN controller
      at91_can: add driver for Atmel's CAN controller on AT91SAM9263

 arch/arm/mach-at91/at91sam9263_devices.c |   36 +
 arch/arm/mach-at91/board-sam9263ek.c     |   19 +
 arch/arm/mach-at91/include/mach/board.h  |    6 +
 drivers/net/can/Kconfig                  |    6 +
 drivers/net/can/Makefile                 |    1 +
 drivers/net/can/at91_can.c               | 1177 ++++++++++++++++++++++++++++++
 6 files changed, 1245 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/at91_can.c
