From: hein_tibosch@yahoo.es (Hein Tibosch)
Date: Mon, 27 Aug 2012 04:36:00 +0800
Subject: [PATCH 0/2] mmc: atmel-mci: repair driver for use with AVR32 (AP7000)
Message-ID: <503A88B0.30103@yahoo.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to changes after 2.6.38, the drivers atmel-mci and dw_dmac got broken
for the AVR32 platform: the AP7000.

These two patches repair the atmel-mci driver

Thanks to Ludovic for reviewing/styling!

Hein Tibosch (2):

  mmc: atmel-mci: DMA can be used with other controller
  mmc: atmel-mci: AP700x PDC is not connected to MCI

 drivers/mmc/host/atmel-mci-regs.h |    7 +++++++
 drivers/mmc/host/atmel-mci.c      |   23 ++++++++++-------------
 2 files changed, 17 insertions(+), 13 deletions(-)

-- 
