From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Thu,  9 Jun 2016 10:26:15 -0500
Subject: [PATCH v2 0/3] ARM: Keystone: Add pinmuxing support
Message-ID: <1465485978-27910-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike most Keystone 2 devices, K2G supports pinmuxing of its pins. This
patch series enables pinmuxing for Keystone 2 devices.

Version 2 changes:
Rebased on top of linux-next which includes Keerthy patches.

Lokesh Vutla (2):
  ARM: dts: keystone: Header file for pinctrl constants
  ARM: dts: k2g-evm: Add pinmuxing for UART0

Vitaly Andrianov (1):
  ARM: dts: k2g: Add pinctrl support

 arch/arm/boot/dts/keystone-k2g-evm.dts | 11 ++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    |  8 +++++++
 include/dt-bindings/pinctrl/keystone.h | 39 ++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/keystone.h

-- 
2.7.0
