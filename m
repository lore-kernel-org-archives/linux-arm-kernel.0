From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:03 +0200
Subject: [PATCH 0/9] make struct of_device_id.data const
In-Reply-To: <1342182734-321-1-git-send-email-y>
References: <1342182734-321-1-git-send-email-y>
Message-ID: <1342182734-321-2-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>


Uwe Kleine-K?nig (9):
  spi/imx: make spi_imx_data.devtype_data member point to const data
  serial/imx: make imx_port.devdata member point to const data
  ARM: cache-l2x0: add a const qualifier
  misc/atmel_tc: make atmel_tc.tcb_config member point to const data
  gpio/gpio-omap.c: add a const qualifier
  i2c/i2c-omap: add a const qualifier
  spi/spi-omap2-mcspi: add a const qualifier
  of: add const to struct of_device_id.data
  gpio/gpio-omap: make platformdata used as of_device_id.data const

 arch/arm/mm/cache-l2x0.c        |    2 +-
 drivers/gpio/gpio-omap.c        |    8 ++++----
 drivers/i2c/busses/i2c-omap.c   |    3 ++-
 drivers/spi/spi-imx.c           |    2 +-
 drivers/spi/spi-omap2-mcspi.c   |    2 +-
 drivers/tty/serial/imx.c        |    2 +-
 include/linux/atmel_tc.h        |    2 +-
 include/linux/mod_devicetable.h |    2 +-
 8 files changed, 12 insertions(+), 11 deletions(-)

-- 
1.7.10
