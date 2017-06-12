From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Jun 2017 10:31:06 -0700
Subject: [GIT PULL 2/5] Broadcom devicetree changes for 4.13
In-Reply-To: <20170612173109.11188-1-f.fainelli@gmail.com>
References: <20170612173109.11188-1-f.fainelli@gmail.com>
Message-ID: <20170612173109.11188-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/devicetree

for you to fetch changes up to 40c26d3af60af5c5d1c434465ffd38a42e5d9bb1:

  ARM: dts: Cygnus: Add the ethernet switch and ethernet PHY (2017-06-12 09:52:37 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based Device Tree changes for 4.13,
please pull the following:

- Rafal adds CPU and thermal zones to the Northstar (BCM5301X) Device Tree and he
  also adds the MDIO controller nodes for later use by USB PHYs

- Eric adds support for the V3D engine and Ethernet switch on the Cygnus platforms

- Jon adds CPU and thermal zones to the Northstar Plus Device Tree files

----------------------------------------------------------------
Eric Anholt (2):
      ARM: dts: Cygnus: Add BCM11360's V3D device
      ARM: dts: Cygnus: Add the ethernet switch and ethernet PHY

Jon Mason (1):
      ARM: dts: NSP: Add Thermal Support

Rafa? Mi?ecki (2):
      ARM: dts: BCM5301X: Add CPU thermal sensor and zone
      ARM: dts: BCM5301X: Specify MDIO bus in the DT

 arch/arm/boot/dts/bcm-cygnus.dtsi      | 71 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm-nsp.dtsi         | 26 +++++++++++++
 arch/arm/boot/dts/bcm5301x.dtsi        | 34 ++++++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts | 20 ++++++++++
 4 files changed, 151 insertions(+)
