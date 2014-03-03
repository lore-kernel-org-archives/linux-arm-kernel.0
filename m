From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Mon,  3 Mar 2014 12:49:01 +0530
Subject: [PATCH v2 0/1] arm64: Add support for Cavium Thunder ARMv8 platform
Message-ID: <1393831142-27952-1-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds preliminary support for Cavium's Thunder SoC which is
based on ARMv8 core.

The Thunder platform is full GICv3 compliant and uses 48-bit Physical
Addresses.

This patch depends on the following submitted patches
1) GICv3 driver from Marc Zyngier
[PATCH 01/18] arm64: initial support for GICv3
http://www.spinics.net/lists/arm-kernel/msg305027.html

2) GICv3 devicetree bindings
[PATCH 02/18] arm64: GICv3 device tree binding documentation
http://www.spinics.net/lists/arm-kernel/msg305023.html

3) Boot time configuration of Intermediate Physical Address size
[RFC PATCH 1/1] arm64: Add boot time configuration of
Intermediate Physical Address size
http://www.spinics.net/lists/arm-kernel/msg312370.html

Changes from v1:
- Removed Kconfig option for Thunder.

Radha Mohan Chintakuntla (1):
  arm64: Add initial dts for Cavium Thunder SoC

 arch/arm64/boot/dts/Makefile    |    1 +
 arch/arm64/boot/dts/thunder.dts |  158 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/boot/dts/thunder.dts
