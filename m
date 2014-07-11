From: addy.ke@rock-chips.com (Addy Ke)
Date: Fri, 11 Jul 2014 10:06:29 +0800
Subject: [PATCH 0/4] patches for rockchip spi driver
Message-ID: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Addy Ke <addy.ke@rockchip.com>

These patches based on:
- git: kernel/git/broonie/spi.git
- branch: topic/rockchip
- commit: c15369087ae5c7db7f3e3604822eac6ab87429bd

Addy Ke (4):
  spi/rockchip: cleanup some coding issues and uncessary output
  spi/rockchip: call wait_for_idle() for the transfer to complete
  spi/rockchip: master->mode_bits: remove SPI_CS_HIGH bit
  spi/rockchip: add compatible strings for RK3188 and RK3288

 drivers/spi/spi-rockchip.c | 74 ++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 29 deletions(-)

-- 
1.8.3.2
