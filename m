From: william.wu@rock-chips.com (William Wu)
Date: Thu, 17 Aug 2017 15:54:48 +0800
Subject: [PATCH v2 0/2] Add usb3 ctrl node on RK3328 SoCs and enable usb3 host
 on RK3328 evb
Message-ID: <1502956490-23087-1-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add support for usb3 controller on RK3328 SoCs.
This series don't include usb3 phy patches, and I will try
to submit usb3 phy patches individually later.

Tested on RK3328 evaluation board.

William Wu (2):
  arm64: dts: rockchip: add usb3 controller node for RK3328 SoCs
  arm64: dts: rockchip: enable usb3 for RK3328 evaluation board

 .../devicetree/bindings/usb/rockchip,dwc3.txt      |  4 +++-
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  9 ++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 27 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.0.0
