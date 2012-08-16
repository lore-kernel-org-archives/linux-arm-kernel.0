From: anilkumar@ti.com (AnilKumar Ch)
Date: Thu, 16 Aug 2012 17:50:06 +0530
Subject: [PATCH 0/4] Add device tree data for AM33XX devices
Message-ID: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl and d_can device tree data to AM33XX family of devices.
First two patches add support for pinctrl DT data and rest adds
dcan DT data.

Reason behind combining these patches is to apply cleanly on
linux-omap devel-dt tree because these are sequential patches.

These patches were tested on AM335x-Bone and AM335x-EVM apply
on linux-omap:devel-dt tree with this patch
http://lkml.org/lkml/2012/8/15/106

AnilKumar Ch (4):
  arm/dts: AM33XX: Add basic pinctrl device tree data
  arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone
  arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on AM335x-EVM
  arm/dts: AM33XX: Add D_CAN device tree data

 arch/arm/boot/dts/am335x-bone.dts |   14 ++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts  |   16 ++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |   27 +++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
1.7.9.5
