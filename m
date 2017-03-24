From: vigneshr@ti.com (Vignesh R)
Date: Fri, 24 Mar 2017 10:57:58 +0530
Subject: [PATCH v2 0/2] serial: Add name field to uart_port
Message-ID: <20170324052800.11526-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds name attribute to uart_port struct inorder to store
name of the tty port that will help in identify different uart
instances.
This patch series is based on discussion here[1].

[1] https://www.spinics.net/lists/arm-kernel/msg569188.html
Previous version:  https://lkml.org/lkml/2017/3/21/328

Vignesh R (2):
  tty: serial_core: Add name field to uart_port struct
  serial: 8250: 8250_core: Fix irq name for 8250 serial IRQ

 drivers/tty/serial/8250/8250_core.c | 2 +-
 drivers/tty/serial/serial_core.c    | 7 +++++++
 include/linux/serial_core.h         | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.11.0
