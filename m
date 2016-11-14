From: wulf@rock-chips.com (William Wu)
Date: Mon, 14 Nov 2016 15:01:49 +0800
Subject: [PATCH v2 0/2] phy: rockchip-inno-usb2: correct 480MHz clk_ops
 callbacks and stable time
Message-ID: <1479106911-16049-1-git-send-email-wulf@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series try to correct the 480MHz output clock of USB2 PHY
clk_ops callback and fix the delay time. It aims to make the
480MHz clock more sensible and stable.

Tested on rk3366/rk3399 EVB board.

William Wu (2):
  phy: rockchip-inno-usb2: correct clk_ops callback
  phy: rockchip-inno-usb2: correct 480MHz output clock stable time

 drivers/phy/phy-rockchip-inno-usb2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.0.0
