From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu,  1 Sep 2016 19:51:29 +0200
Subject: [PATCH 0/9] constify uart_ops structures
Message-ID: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Constify uart_ops structures.

---

 drivers/tty/serial/altera_jtaguart.c |    2 +-
 drivers/tty/serial/altera_uart.c     |    2 +-
 drivers/tty/serial/arc_uart.c        |    2 +-
 drivers/tty/serial/atmel_serial.c    |    2 +-
 drivers/tty/serial/bcm63xx_uart.c    |    2 +-
 drivers/tty/serial/fsl_lpuart.c      |    4 ++--
 drivers/tty/serial/imx.c             |    2 +-
 drivers/tty/serial/jsm/jsm_tty.c     |    2 +-
 drivers/tty/serial/max3100.c         |    2 +-
 drivers/tty/serial/men_z135_uart.c   |    2 +-
 drivers/tty/serial/mxs-auart.c       |    2 +-
 drivers/tty/serial/pch_uart.c        |    2 +-
 drivers/tty/serial/sh-sci.c          |    2 +-
 drivers/tty/serial/st-asc.c          |    2 +-
 drivers/tty/serial/timbuart.c        |    2 +-
 drivers/tty/serial/uartlite.c        |    2 +-
 drivers/tty/serial/xilinx_uartps.c   |    2 +-
 17 files changed, 18 insertions(+), 18 deletions(-)
