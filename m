From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 20 Oct 2017 18:22:44 -0700
Subject: [GIT PULL 1/3] ARM: Keystone DTS update for 4.15
Message-ID: <1508548966-7350-1-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e19b205be43d11bff638cad4487008c48d21c103:

  Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.15

for you to fetch changes up to 1efed4072c5992ede080987e6d83dfead6af126a:

  ARM: dts: keystone-k2g-evm: add bindings for SPI NOR flash (2017-10-10 09:42:56 -0700)

----------------------------------------------------------------
ARM: Keystone DTS update for 4.15

- McASP support for K2G EVM
- I2C support for K2G EVM
- USB support for K2G EVM
- SPI & SPI NOR flash support for K2G EVM
- ECAP PWM support for K2G EVM

----------------------------------------------------------------
Murali Karicheri (2):
      ARM: dts: keystone-k2g-evm: Add I2C EEPROM DT entry
      ARM: dts: keystone-k2g-evm: add bindings for SPI NOR flash

Peter Ujfalusi (1):
      ARM: dts: keystone-k2g: Add McASP nodes

Roger Quadros (1):
      ARM: dts: k2g-evm: Enable USB 0 and 1

Vignesh R (2):
      ARM: dts: keystone-k2g: Add ECAP PWM DT nodes
      ARM: dts: keystone-k2g-evm: Enable PWM ECAP0

Vitaly Andrianov (3):
      ARM: dts: keystone-k2g: Add I2C nodes
      ARM: dts: k2g: Add USB instances
      ARM: dts: keystone-k2g: Add SPI nodes

 arch/arm/boot/dts/keystone-k2g-evm.dts |  93 +++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    | 208 +++++++++++++++++++++++++++++++++
 2 files changed, 301 insertions(+)
