From: vigneshr@ti.com (Vignesh R)
Date: Thu, 8 Feb 2018 18:25:40 +0530
Subject: [PATCH 0/2] 8250_omap: Fix issues with throttling of 8250 port
Message-ID: <20180208125542.15649-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains couple of fixes related to throttling of 8250 uart
port when tty buffer is under pressure.


Vignesh R (2):
  serial: 8250: Don't service RX FIFO if interrupts are disabled
  serial: 8250: 8250_omap: Fix throttling when DMA is enabled

 drivers/tty/serial/8250/8250_omap.c | 11 ++++++++++-
 drivers/tty/serial/8250/8250_port.c |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.16.1
