From: nm@ti.com (Nishanth Menon)
Date: Thu, 24 Mar 2016 17:52:47 -0500
Subject: [PATCH 0/2] ARM: DRA72: Add support for rev C evm
Message-ID: <1458859969-14298-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
please find support for DRA72 rev C evm support 

Test log: http://pastebin.ubuntu.com/15491059/
Based on 6f30d29c603c Add linux-next specific files for 20160324

Nishanth Menon (2):
  ARM: dts: Add support for dra72-evm rev C (ES2.0)
  ARM: omap2plus_defconfig: Enable DP83867 support

 arch/arm/boot/dts/Makefile                         |   3 +-
 .../dts/{dra72-evm.dts => dra72-evm-common.dtsi}   |  26 +-
 arch/arm/boot/dts/dra72-evm-revc.dts               |  73 ++
 arch/arm/boot/dts/dra72-evm.dts                    | 835 +--------------------
 arch/arm/configs/omap2plus_defconfig               |   1 +
 5 files changed, 90 insertions(+), 848 deletions(-)
 copy arch/arm/boot/dts/{dra72-evm.dts => dra72-evm-common.dtsi} (97%)
 create mode 100644 arch/arm/boot/dts/dra72-evm-revc.dts

-- 
2.8.0.rc3
