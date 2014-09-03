From: dianders@chromium.org (Doug Anderson)
Date: Wed,  3 Sep 2014 13:44:24 -0700
Subject: [PATCH 0/3] SPI Fixes for spi-rockchip
Message-ID: <1409777067-17422-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These three patches are random SPI fixes for spi-rockchip.  They are
unrelated and can be applied / NAKed separately.  They've been tested
in PIO mode on an rk3288 board (since SPI DMA isn't currently working
for some unknown reason).


Doug Anderson (3):
  spi/rockchip: Fix the wait_for_idle() timeout
  spi/rockchip: Don't warn if SPI is busy but disabled
  dt-bindings: spi/rockchip: Mark DMA as optional

 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 8 ++++++--
 drivers/spi/spi-rockchip.c                             | 5 +++--
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5
