From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 12 Jul 2017 11:03:22 +0100
Subject: [PATCH 0/3] Add MMCIF0 support for r8a7743/iwg20m
Message-ID: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds MMCIF0 support for the r8a7743 SoC and the iWave-RZG1M-20M
Qseven SOM.

This series is based on renesas-devel-20170711-v4.12.

Chris Paterson (3):
  dt-bindings: mmc: sh_mmcif: Document r8a7743 DT bindings
  ARM: dts: r8a7743: Add MMCIF0 support
  ARM: dts: iwg20m: Add MMCIF0 support

 .../devicetree/bindings/mmc/renesas,mmcif.txt      |  3 ++-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              | 26 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7743.dtsi                     | 16 +++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

-- 
1.9.1
