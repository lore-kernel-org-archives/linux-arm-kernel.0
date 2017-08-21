From: william.wu@rock-chips.com (William Wu)
Date: Mon, 21 Aug 2017 21:36:03 +0800
Subject: [PATCH v3 0/3] Add usb3 ctrl node on RK3328 SoCs and enable usb3 host
 on RK3328 evb
Message-ID: <1503322566-31489-1-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add support for usb3 controller on RK3328 SoCs.
This series don't include usb3 phy patches, and I will try
to submit usb3 phy patches individually later.

Tested on RK3328 evaluation board.

William Wu (3):
  dt-bindings: usb: add DT binding for RK3328 dwc3 controller
  arm64: dts: rockchip: add usb3 controller node for RK3328 SoCs
  arm64: dts: rockchip: enable usb3 for RK3328 evaluation board

 .../devicetree/bindings/usb/rockchip,dwc3.txt      |  4 +++-
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  9 ++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 27 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.0.0
