From: j-keerthy@ti.com (Keerthy)
Date: Mon, 23 May 2016 17:59:04 +0530
Subject: [PATCH 0/3] ARM: keystone-k2l: Enable pinctrl support
Message-ID: <1464006547-19569-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series enables pinctrl support for k2l devices.
Tested on keystone-k2l-evm board.

Keerthy (3):
  ARM: dts: keystone-k2l: Add pinctrl node
  arm: mach-keystone: Enable PINCTRL config
  ARM: configs: keystone: Enable PINCTRL_SINGLE Config

 arch/arm/boot/dts/keystone-k2l.dtsi | 149 ++++++++++++++++++++++++++++++++++++
 arch/arm/configs/keystone_defconfig |   1 +
 arch/arm/mach-keystone/Kconfig      |   1 +
 3 files changed, 151 insertions(+)

-- 
1.9.1
