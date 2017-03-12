From: jnair@caviumnetworks.com (Jayachandran C)
Date: Sun, 12 Mar 2017 10:03:33 +0000
Subject: [PATCH v5 0/2] ARCH_VULCAN to ARCH_THUNDER2 transition
Message-ID: <1489313015-4783-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are the updated versions of two patches of the series that did
not get into 4.11.  The patches are move the device trees to their
new location and to document the new cpu and core names.

JC.

Jayachandran C (2):
  dt-bindings: arm64 ARCH_THUNDER2 platform documentation
  arm64: dts: move from ARCH_VULCAN to ARCH_THUNDER2

 .../devicetree/bindings/arm/cavium-thunder2.txt    |   8 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 arch/arm64/boot/dts/broadcom/Makefile              |   1 -
 arch/arm64/boot/dts/broadcom/vulcan-eval.dts       |  33 -----
 arch/arm64/boot/dts/broadcom/vulcan.dtsi           | 147 ---------------------
 arch/arm64/boot/dts/cavium/Makefile                |   1 +
 arch/arm64/boot/dts/cavium/thunder2-99xx.dts       |  33 +++++
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi      | 147 +++++++++++++++++++++
 8 files changed, 190 insertions(+), 181 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt
 delete mode 100644 arch/arm64/boot/dts/broadcom/vulcan-eval.dts
 delete mode 100644 arch/arm64/boot/dts/broadcom/vulcan.dtsi
 create mode 100644 arch/arm64/boot/dts/cavium/thunder2-99xx.dts
 create mode 100644 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi

-- 
2.7.4
