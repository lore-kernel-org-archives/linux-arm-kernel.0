From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Wed, 26 Feb 2014 11:32:50 +0530
Subject: [PATCH 0/2] Add support for Cavium Thunder ARMv8 platform 
Message-ID: <1393394572-6269-1-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch series adds preliminary support for Cavium's Thunder SoC
which is based on ARMv8 core.

This patchset depends on
1) GICv3 driver from Marc Zyngier
[PATCH 01/18] arm64: initial support for GICv3
http://www.spinics.net/lists/arm-kernel/msg305027.html

2) GICv3 devicetree bindings
[PATCH 02/18] arm64: GICv3 device tree binding documentation
http://www.spinics.net/lists/arm-kernel/msg305023.html

3) 48-bit Physical Address support for ARMv8 cores from Radha Mohan
Chintakuntla
[PATCH 1/1] arm64: Add support for 48-bit Physical Address
http://www.spinics.net/lists/arm-kernel/msg311035.html

Radha Mohan Chintakuntla (2):
  arm64: Add Kconfig option for Cavium Thunder SoC Family
  arm64: Add initial dts for Cavium Thunder SoC

 arch/arm64/Kconfig              |    6 ++
 arch/arm64/boot/dts/Makefile    |    1 +
 arch/arm64/boot/dts/thunder.dts |  158 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/boot/dts/thunder.dts
