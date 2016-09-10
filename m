From: andy.yan@rock-chips.com (Andy Yan)
Date: Sun, 11 Sep 2016 01:40:48 +0800
Subject: [PATCH v1 0/2] Add two automotive field Evaluation boards from
 rockchip
Message-ID: <1473529249-6151-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Changes in v1:
- board rename
- add vendor prefix for i2c interfaced sensors
- use stdout-path to set the default console

Andy Yan (2):
  ARM: dts: add rockchip PX3 Evaluation board
  arm64: dts: rockchip: Add PX5 Evaluation board

 Documentation/devicetree/bindings/arm/rockchip.txt |   8 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3188-px3-evb.dts               | 337 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    | 304 +++++++++++++++++++
 5 files changed, 651 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3188-px3-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts

-- 
2.7.4
