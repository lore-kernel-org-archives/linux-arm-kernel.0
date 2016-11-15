From: wulf@rock-chips.com (William Wu)
Date: Tue, 15 Nov 2016 11:54:05 +0800
Subject: [PATCH v4 0/2] phy: rockchip-inno-usb2: correct 480MHz clk_ops
 callbacks and stable time
Message-ID: <1479182047-3399-1-git-send-email-wulf@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series try to correct the 480MHz output clock of USB2 PHY
clk_ops callback and fix the delay time. It aims to make the
480MHz clock gate more sensible and stable.

Tested on rk3366/rk3399 EVB board.

William Wu (2):
  phy: rockchip-inno-usb2: correct clk_ops callback
  phy: rockchip-inno-usb2: correct 480MHz output clock stable time

 drivers/phy/phy-rockchip-inno-usb2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.0.0
