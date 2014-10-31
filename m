From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 Oct 2014 23:13:29 +0100
Subject: [PATCH 0/4] Support for DLINK DIR665
Message-ID: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DLINK is a wireless access point using a Kirkwood processor
and a Marvell TopDog wifi chipset.

The base device tree file was provided by Claudio Leite. I've
performed a few cleanups, added dsa support for the in build switch,
and extended the defconfigs for regression testing.

Andrew Lunn (3):
  ARM: Kirkwood: DIR665: Instantiate Distributed Switch Architecture
  ARM: mvebu: Add DLINK DIR665 options to mvebu_v5_defconfig
  ARM: config: Add DLINK DIR665 options to multi_v5_defconfig

Claudio Leite (1):
  ARM: Kirkwood: Add support for DLink DIR665

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/kirkwood-dir665.dts | 278 ++++++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v5_defconfig   |   2 +
 arch/arm/configs/mvebu_v5_defconfig   |   2 +
 4 files changed, 283 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-dir665.dts

-- 
2.1.1
