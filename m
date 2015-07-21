From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 21 Jul 2015 22:17:57 +0800
Subject: [PATCH 0/2] arm64: Add basic support for Marvell Berlin4CT SoC
Message-ID: <1437488279-2088-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell Berlin4CT is a SoC based on 64bit ARMv8 architecture. It contains
quad CA53 cores.

This SoC shares many HW IP with BG2Q and other berlin series. This patchset was tested
on Berlin4CT DMP board, and boot to shell ok.

Jisheng Zhang (2):
  arm64: dts: Add dts files for Marvell Berlin4CT SoC
  arm64: Enable Marvell Berlin SoC family in Kconfig and defconfig

 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/marvell/Makefile          |   5 +
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts |  68 +++++++++++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 160 ++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 6 files changed, 241 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/Makefile
 create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
 create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct.dtsi

-- 
2.1.4
