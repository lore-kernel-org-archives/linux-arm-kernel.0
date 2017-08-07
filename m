From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon,  7 Aug 2017 20:40:17 +0800
Subject: [PATCH 0/3] Fix clock handling in rockchip spi suspend/resume/remove
Message-ID: <1502109620-26813-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I saw unpaired spi clock disable warnings when suspend/unbind spi device.
Fix them follow spi-s3c64xx.c.



Jeffy Chen (3):
  spi: rockchip: Slightly rework return value handling
  spi: rockchip: Fix clock handling in remove
  spi: rockchip: Fix clock handling in suspend/resume

 drivers/spi/spi-rockchip.c | 51 +++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

-- 
2.1.4
