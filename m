From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Fri, 7 Jun 2013 17:02:51 +0530
Subject: [PATCH 0/3] Add pinmux DT nodes to CPSW for AM335x
Message-ID: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux DT nodes to CPSW for the following AM335x boards
* AM335x Beaglebone
* AM335x EVM
* AM335x EVMsk
default state contains the pinmux required for active mode and
sleep mode contains pinmux reset values for energy saving.

Mugunthan V N (3):
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to beaglebone
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to EVMsk
  ARM: dts: AM33XX: Add pinmux configuration for CPSW to am335x EVM

 arch/arm/boot/dts/am335x-bone.dts  |   67 ++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts   |   64 +++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts |   92 ++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)

-- 
1.7.9.5
