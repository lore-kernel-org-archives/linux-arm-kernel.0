From: rk@ti.com (Ravikumar Kattekola)
Date: Wed, 25 May 2016 18:23:39 +0530
Subject: [PATCH 0/2] arm: dra7: Add i2c6 instance hwmod and dt entries
Message-ID: <20160525125341.10044-1-rk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA72x devices have a sixth i2c ocntroller instance.
Following patches add the required hwmod structure and
device tree nodes.

Reference doc: DRA72x TRM [ SPRUHP2Q ]

Tested on :
DRA72x Rev B EVM

Ravikumar Kattekola (2):
  arm: dra7: Add hwmod entry for i2c6
  dts: dra7: Add device tree node for i2c6

 arch/arm/boot/dts/dra7.dtsi               | 11 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.8.2.396.g5fe494c
