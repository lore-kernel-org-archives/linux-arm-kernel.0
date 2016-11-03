From: wulf@rock-chips.com (William Wu)
Date: Thu,  3 Nov 2016 10:06:12 +0800
Subject: [PATCH v2 0/2] support USB2 PHY OTG port for rk3399
Message-ID: <1478138774-3254-1-git-send-email-wulf@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add support for rk3399 USB2 PHY0 and PHY1 OTG port.
rk3399 has two USB2 PHYs, and each USB2 PHY is comprised of one
Host port and one OTG port. We have supported Host port before,
and try to support OTG port now.

Test on rk3399-evb board.

William Wu (2):
  phy: rockchip-inno-usb2: support otg-port for rk3399
  arm64: dts: rockchip: add usb2-phy otg-port support for rk3399

 arch/arm64/boot/dts/rockchip/rk3399.dtsi |  21 ++
 drivers/phy/phy-rockchip-inno-usb2.c     | 593 +++++++++++++++++++++++++++++--
 2 files changed, 583 insertions(+), 31 deletions(-)

-- 
2.0.0
