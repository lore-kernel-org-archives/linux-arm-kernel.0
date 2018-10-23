From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 23 Oct 2018 13:06:05 +0200
Subject: [PATCH 0/3] Fix MODULE_LICENSE of bcm2835 drivers
Message-ID: <1540292769-5905-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of a treewide switch of all bcm2835 drivers to SPDX tags,
we need to make sure that the license text and MODULE_LICENSE matches.

This series starts sooner than usual to have more time to collect the authors
ACK.

Stefan Wahren (3):
  clk: bcm2835: make license text and module license match
  dma: bcm2835: make license text and module license match
  spi: bcm2835: make license text and module license match

 drivers/clk/bcm/clk-bcm2835-aux.c | 2 +-
 drivers/clk/bcm/clk-bcm2835.c     | 2 +-
 drivers/dma/bcm2835-dma.c         | 2 +-
 drivers/spi/spi-bcm2835.c         | 2 +-
 drivers/spi/spi-bcm2835aux.c      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4
