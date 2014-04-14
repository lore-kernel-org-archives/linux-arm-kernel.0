From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 14 Apr 2014 14:29:56 +0800
Subject: [PATCH 0/5] spi : sirf: some chip-select, DMA and checkpatch fixes
Message-ID: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

this patchset fixes some IO transferring issues and fixes checkpatch issues.

Qipan Li (5):
  spi: sirf: correct TXFIFO empty interrupt status bit
  spi: sirf: set SPI controller in RISC IO chipselect mode
  spi: sirf: make GPIO chipselect function work well
  spi: sirf: fix line over 80 characters style issue
  spi: sirf: fix spi full-duplex DMA transferring issue

 drivers/spi/spi-sirf.c |   74 +++++++++++++++++++++++++++++++++--------------
 1 files changed, 52 insertions(+), 22 deletions(-)

-- 
1.7.5.4
