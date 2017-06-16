From: william.wu@rock-chips.com (William Wu)
Date: Fri, 16 Jun 2017 17:46:04 +0800
Subject: [PATCH 0/2] Add usb2 nodes on RK3328 SoCs and enable usb2 on RK3328
 evb
Message-ID: <1497606366-1012-1-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for usb2 on RK3328 SoCs.
Tested on RK3328 evaluation board.

William Wu (2):
  arm64: dts: rockchip: add usb2 nodes for RK3328 SoCs
  arm64: dts: rockchip: enable usb2 for RK3328 evaluation board

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 25 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi    | 76 +++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

-- 
2.0.0
