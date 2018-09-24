From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Sep 2018 11:12:15 -0700
Subject: [GIT PULL 1/1] Broadcom devicetree fixes for 4.19
Message-ID: <20180924181215.7573-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.19/devicetree-fixes

for you to fetch changes up to 3ab97942d0213b6583a5408630a8cbbfbf54730f:

  ARM: dts: BCM63xx: Fix incorrect interrupt specifiers (2018-09-24 11:04:04 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree changes
intended for 4.19, please pull the following:

- Florian fixes the PPI and SPI interrupts in the BCM63138 (DSL) SoC DTS

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: dts: BCM63xx: Fix incorrect interrupt specifiers

 arch/arm/boot/dts/bcm63138.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)
