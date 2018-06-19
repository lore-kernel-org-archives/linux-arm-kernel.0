From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Jun 2018 16:31:02 -0700
Subject: [GIT PULL 1/3] Broadcom devicetree fixes for 4.18
Message-ID: <20180619233104.32173-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/devicetree-fixes

for you to fetch changes up to 6cb1628ad3506b315cdddd7676db0ff2af378d28:

  ARM: dts: Cygnus: Fix PCIe controller interrupt type (2018-06-18 09:40:36 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree fixes for
4.18, please pull the following:

- Ray fixes the I2C and PCIe interrupt types for the Cygnus SoC

- Florian fixes the I2C and PCIe interrupts for the Northstar
  (BCM5301x), Northstar Plus and Hurricane 2 SoCs

----------------------------------------------------------------
Florian Fainelli (4):
      ARM: dts: NSP: Fix i2c controller interrupt type
      ARM: dts: NSP: Fix PCIe controllers interrupt types
      ARM: dts: HR2: Fix interrupt types for i2c and PCIe
      ARM: dts: BCM5301x: Fix i2c controller interrupt type

Ray Jui (2):
      ARM: dts: Cygnus: Fix I2C controller interrupt type
      ARM: dts: Cygnus: Fix PCIe controller interrupt type

 arch/arm/boot/dts/bcm-cygnus.dtsi | 24 ++++++++++++------------
 arch/arm/boot/dts/bcm-hr2.dtsi    | 24 ++++++++++++------------
 arch/arm/boot/dts/bcm-nsp.dtsi    | 32 ++++++++++++++++----------------
 arch/arm/boot/dts/bcm5301x.dtsi   |  2 +-
 4 files changed, 41 insertions(+), 41 deletions(-)
