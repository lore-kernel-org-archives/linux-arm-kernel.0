From: jnair@caviumnetworks.com (Jayachandran C)
Date: Fri, 20 Jan 2017 20:46:38 +0000
Subject: [PATCH 0/3] arm64: Add ARCH_THUNDER2
Message-ID: <1484945201-17248-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the new ThunderX2 CN99XX processor
family.

Changes are to add the config option, the required device tree files,
the device tree bindings documentation and the defconfig entry.

JC.

Jayachandran C (3):
  arm64: add THUNDER2 processor family
  dt-bindings: arm64 ARCH_THUNDER2 platform documentation
  arm64: add ARCH_THUNDER2 to defconfig

 .../devicetree/bindings/arm/cavium-thunder2.txt    |   5 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 arch/arm64/Kconfig.platforms                       |   7 +
 arch/arm64/boot/dts/cavium/Makefile                |   1 +
 arch/arm64/boot/dts/cavium/thunder-99xx.dts        |  34 +++++
 arch/arm64/boot/dts/cavium/thunder-99xx.dtsi       | 147 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 7 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt
 create mode 100644 arch/arm64/boot/dts/cavium/thunder-99xx.dts
 create mode 100644 arch/arm64/boot/dts/cavium/thunder-99xx.dtsi

-- 
2.7.4
