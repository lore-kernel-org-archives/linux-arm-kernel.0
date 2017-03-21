From: vigneshr@ti.com (Vignesh R)
Date: Tue, 21 Mar 2017 19:06:34 +0530
Subject: [PATCH 0/2] serial: Add name field to uart_port
Message-ID: <20170321133636.8814-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds name attribute to uart_port struct inorder to store
name of the tty port that will help in identify different uart
instances.
This patch series is based on discussion here[1].


[1] https://www.spinics.net/lists/arm-kernel/msg569188.html

Vignesh R (2):
  tty: serial_core: Add name field to uart_port struct
  serial: 8250: 8250_core: Fix irq name for 8250 serial irq

 drivers/tty/serial/8250/8250_core.c | 2 +-
 drivers/tty/serial/serial_core.c    | 2 ++
 include/linux/serial_core.h         | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.11.0
