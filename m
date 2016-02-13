From: jchandra@broadcom.com (Jayachandran C)
Date: Sun, 14 Feb 2016 00:16:31 +0530
Subject: [PATCH 0/4] Support for Broadcom Vulcan ARM64 processor
Message-ID: <1455389195-31870-1-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for Broadcom's Vulcan CPU.

The changes are to add the a device tree (dtsi) for the
Vulcan SoC, a device tree(dts) for developer platform
and related documentation.

Review comments and suggestions are very welcome.

Thanks,
JC.

Jayachandran C (3):
  dt-bindings: Add documentation for Broadcom Vulcan
  arm64: defconfig: Add Broadcom Vulcan to defconfig
  arm64: cputype info for Broadcom Vulcan

Zi Shen Lim (1):
  arm64: Broadcom Vulcan support

 .../devicetree/bindings/arm/bcm/brcm,vulcan.txt    |   9 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/broadcom/Makefile              |   1 +
 arch/arm64/boot/dts/broadcom/brcm-vulcan-eval.dts  |  33 +++++
 arch/arm64/boot/dts/broadcom/brcm-vulcan.dtsi      | 146 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 arch/arm64/include/asm/cputype.h                   |   2 +
 8 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/brcm-vulcan-eval.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/brcm-vulcan.dtsi

-- 
1.9.1
