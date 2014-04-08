From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 8 Apr 2014 14:46:05 +0300
Subject: [PATCH v2 0/2] ARM: dts: keystone: i2c updates
Message-ID: <1396957567-14540-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

There are two small non critical fixes for Keystone 2 I2C DT definitions.

Changes in v2;
- added additional patch to move i2c0 device node from SoC to board files
- updated commits messages

Grygorii Strashko (2):
  ARM: dts: keystone: add cell's information to i2c nodes
  ARM: dts: keystone: move i2c0 device node from SoC to board files

 arch/arm/boot/dts/k2e-evm.dts   |    7 +++++++
 arch/arm/boot/dts/k2hk-evm.dts  |    7 +++++++
 arch/arm/boot/dts/k2l-evm.dts   |    7 +++++++
 arch/arm/boot/dts/keystone.dtsi |    9 ++++-----
 4 files changed, 25 insertions(+), 5 deletions(-)

-- 
1.7.9.5
