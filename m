From: j-keerthy@ti.com (Keerthy)
Date: Mon, 6 Jun 2016 10:15:03 +0530
Subject: [PATCH 0/3] ARM: keystone-k2l: Enable pinctrl support
Message-ID: <1465188306-32556-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series enables pinctrl support for k2l devices.
Tested on keystone-k2l-evm board.

Franklin S Cooper Jr (1):
  ARM: configs: keystone: Enable PINCTRL_SINGLE Config

Keerthy (1):
  ARM: dts: keystone-k2l: Add pinctrl node

Lokesh Vutla (1):
  arm: mach-keystone: Enable PINCTRL config

 arch/arm/boot/dts/keystone-k2l.dtsi | 149 ++++++++++++++++++++++++++++++++++++
 arch/arm/configs/keystone_defconfig |   1 +
 arch/arm/mach-keystone/Kconfig      |   1 +
 3 files changed, 151 insertions(+)

-- 
1.9.1
