From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 27 Apr 2016 09:11:43 -0500
Subject: [PATCH 0/5] ARM:Keystone: Add pinmuxing support
Message-ID: <1461766308-27669-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike most Keystone 2 devices, K2G supports pinmuxing of its pins. This
patch series enables pinmuxing for Keystone 2 devices.

Franklin S Cooper Jr (1):
  ARM: keystone: defconfig: Enable PINCTRL SINGLE for Keystone 2

Lokesh Vutla (3):
  ARM: Keystone: Enable PINCTRL for Keystone ARCH
  ARM: dts: keystone: Header file for pinctrl constants
  ARM: dts: k2g-evm: Add pinmuxing for UART0

Vitaly Andrianov (1):
  ARM: dts: k2g: Add pinctrl support

 arch/arm/boot/dts/keystone-k2g-evm.dts | 11 ++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    |  8 +++++++
 arch/arm/configs/keystone_defconfig    |  1 +
 arch/arm/mach-keystone/Kconfig         |  1 +
 include/dt-bindings/pinctrl/keystone.h | 39 ++++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/keystone.h

-- 
2.7.0
