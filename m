From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 9 Jul 2014 16:14:17 +0300
Subject: [PATCH 0/3] ARM: keystone: enable mdio support
Message-ID: <1404911660-10047-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT definitions for Keystone 2 MDIO module and Ethernet PHYs for Keystone
EVMK2HX evm. And enable MDIO support for Keystone 2 SoCs.

Grygorii Strashko (3):
  ARM: dts: keystone: add mdio devices entries
  ARM: dts: keystone-evm: add 1g ethernet phys nodes
  ARM: keystone_defconfig: enable mdio and marvell eth phys

 arch/arm/boot/dts/k2hk-evm.dts      |   12 ++++++++++++
 arch/arm/boot/dts/keystone.dtsi     |   11 +++++++++++
 arch/arm/configs/keystone_defconfig |    2 ++
 3 files changed, 25 insertions(+)

-- 
1.7.9.5
