From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 13:21:40 -0500
Subject: [PATCH v2 0/2] ARM: dts: keystone-k2g-evm: Add I2C nodes and enable
 I2C0 on K2G EVM
Message-ID: <20170908182142.5274-1-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C DT nodes for 66AK2G. Also enable I2C0 in K2G EVM which is needed
to access the I2C EEPROM. 

Version 2 changes:
No real changes. Split patches into their own patchset

Murali Karicheri (1):
  ARM: dts: keystone-k2g-evm: Add I2C EEPROM DT entry

Vitaly Andrianov (1):
  ARM: dts: keystone-k2g: Add I2C nodes

 arch/arm/boot/dts/keystone-k2g-evm.dts | 19 ++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

-- 
2.9.4.dirty
