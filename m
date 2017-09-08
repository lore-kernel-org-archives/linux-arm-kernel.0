From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 13:41:30 -0500
Subject: [PATCH v2 0/2] ARM: dts: keystone-k2g-evm: Add USB nodes and enable
 USB on K2G EVM
Message-ID: <20170908184132.6155-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB nodes to 66AK2G dtsi. Also enable the two USB nodes that are on
the K2G EVM.

Roger Quadros (1):
  ARM: dts: k2g-evm: Enable USB 0 and 1

Vitaly Andrianov (1):
  ARM: dts: k2g: Add USB instances

 arch/arm/boot/dts/keystone-k2g-evm.dts | 26 ++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    | 56 ++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

-- 
2.9.4.dirty
