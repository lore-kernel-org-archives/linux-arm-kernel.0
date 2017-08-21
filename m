From: frank.wang@rock-chips.com (Frank Wang)
Date: Mon, 21 Aug 2017 16:39:25 +0800
Subject: [PATCH 0/3] add usb support for rv1108 SoCs
Message-ID: <1503304768-14520-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds USB related device nodes support for rv1108 SoCs, in addition,
Rockchip's rv1108-evb board has one usb otg controller and one usb host
controller, each controller connect with one usb-phy port through UTMI+
interface, the changes also enable usb related for rv1108-evb board.

Frank Wang (3):
  dt-bindings: update dt-binding for rv1108 SoCs
  ARM: dts: rockchip: add usb nodes for rv1108 SoCs
  ARM: dts: rockchip: enable usb for rv1108-evb

 .../devicetree/bindings/soc/rockchip/grf.txt       |  3 +
 arch/arm/boot/dts/rv1108-evb.dts                   | 24 +++++++
 arch/arm/boot/dts/rv1108.dtsi                      | 73 +++++++++++++++++++++-
 3 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.0.0
