From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:01:00 +0800
Subject: [PATCH 0/8] spi: sirf: a bundle of fixes and cleanups
Message-ID: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

this patchset fixes the cs_gpio, cmd_mode, make DMA optional etc.

Qipan Li (8):
  spi: sirf: correct spi gpio and hardware chipselect behaviour
  spi: sirf: request and free cs gpio in setup and cleanup callbacks
  spi: sirf: enable RX_IO_DMA_INT interrupt
  spi: sirf: fix 'cmd_transfer' function typos
  spi: sirf: add fifo reset/start for cmd transfer
  spi: sirf: set default spi frequency if it is not set
  spi: sirf: cleanup the indentation of marcos
  spi: sirf: make DMA transfer mode optional

 drivers/spi/Kconfig    |  10 ++++
 drivers/spi/spi-sirf.c | 148 ++++++++++++++++++++++++++-----------------------
 2 files changed, 89 insertions(+), 69 deletions(-)

-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
