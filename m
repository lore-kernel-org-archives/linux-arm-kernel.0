From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 30 Jul 2015 13:43:33 +0530
Subject: [PATCH 0/7] ARM: dts: MMC fixes for DRA7 based boards
Message-ID: <1438244020-4244-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miscellaneous fixes in dts files for MMC device tree nodes.

Did basic read/write test in J6, J6 Eco and Beagle-x15

Balaji T K (1):
  ARM: dts: dra7-evm: add evm_3v3_sd regulator

Kishon Vijay Abraham I (5):
  ARM: dts: dra72-evm: add evm_3v3_sd regulator
  ARM: dts: dra72-evm: Set max clock frequency of MMC1 and MMC2
  ARM: dts: am57xx-beagle-x15: mmc1: remove redundant pbias-supply
    property
  ARM: dts: dra7-evm: Fix spurious card insert/removal interrupt
  ARM: dts: dra72-evm: Fix spurious card insert/removal interrupt

Nishanth Menon (1):
  ARM: dts: dra7-evm: Add MMCSD card removal GPIO

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 -
 arch/arm/boot/dts/dra7-evm.dts          |   18 +++++++++++++++++-
 arch/arm/boot/dts/dra72-evm.dts         |   16 ++++++++++++++--
 3 files changed, 31 insertions(+), 4 deletions(-)

-- 
1.7.9.5
