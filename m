From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed,  5 Jul 2017 16:30:15 +0800
Subject: [PATCH v2 0/6] add and enable some device nodes for rk3229-evb board
Message-ID: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These series add and enable regulators, gpio-keys, eMMC and other device
nodes support for rk3229-evb board.

Changes from v1:
 - Fixed the name and supply for regulator nodes in [PATCH 1/6].
 - Deleted some redundant properties of eMMC in [PATCH 4/6].

David Wu (1):
  ARM: dts: rockchip: enable io-domain for rk3229-evb

Finley Xiao (1):
  ARM: dts: rockchip: add cpu-supply property for cpu node of rk3229-evb

Frank Wang (4):
  ARM: dts: rockchip: add regulator nodes for rk3229-evb
  ARM: dts: rockchip: enable eMMC for rk3229-evb
  ARM: dts: rockchip: enable tsadc for rk3229-evb
  ARM: dts: rockchip: add gpio power-key for rk3229-evb

 arch/arm/boot/dts/rk3229-evb.dts | 117 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

-- 
2.0.0
