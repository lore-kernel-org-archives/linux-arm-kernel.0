From: addy.ke@rock-chips.com (Addy Ke)
Date: Wed, 15 Oct 2014 19:25:11 +0800
Subject: [PATCH 0/2] spi: fix two bugs
Message-ID: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1: fix bug that case spi can't go as fast as slave request
Patch 2: fix bug that cause spi transfer timed out in DMA duplex mode

Tested on rk3288-pinky-version2 board.

Addy Ke (2):
  spi/rockchip: fix bug that case spi can't go as fast as slave request
  spi/rockchip: fix bug that cause spi transfer timed out in DMA duplex
    mode

 drivers/spi/spi-rockchip.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

-- 
1.8.3.2
