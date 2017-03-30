From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Thu, 30 Mar 2017 10:29:05 -0500
Subject: [PATCH 0/2] ARM: dts: keystone: Add support for new K2G evm
Message-ID: <20170330152907.12595-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for new K2G Industrial Communication Engine
evm. For now only a bare minimal dts which will allow ram boot. Additional
peripherals will be added when base K2G SoC patches are upstreamed allowing
peripherals to be enabled.

Bootlog: https://pastebin.ubuntu.com/24281838/

Franklin S Cooper Jr (2):
  ARM: keystone: Create new binding for K2G ICE evm
  ARM: dts: keystone: Add minimum support for K2G ICE evm

 .../devicetree/bindings/arm/keystone/keystone.txt  |  3 ++
 arch/arm/boot/dts/Makefile                         |  3 +-
 arch/arm/boot/dts/keystone-k2g-ice.dts             | 42 ++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/keystone-k2g-ice.dts

-- 
2.10.0
