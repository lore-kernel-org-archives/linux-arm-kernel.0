From: joel@jms.id.au (Joel Stanley)
Date: Thu, 24 Aug 2017 13:44:38 +0930
Subject: [GIT PULL] ARM: config: aspeed: Changes for 4.14
Message-ID: <CACPK8XehxPjTuAq70ofmom9_DJ7LBR2C0ehO+2jGJUANTXod+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here's two Aspeed defconifg changes for 4.14.

This is a bit later than I planned, sorry about that. These changes
have been kicking around for a while now so they areb well tested.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.14-defconfig

for you to fetch changes up to 652213cd1081017e2139d57b6c7871670e41bf0b:

  ARM: config: aspeed: Add I2C, VUART, LPC Snoop (2017-08-23 16:04:42 +0930)

----------------------------------------------------------------
Aspeed defconfig updates for 4.14

 - Enable new Aspeed drivers for i2c, lpc snoop and vuart
 - Set VMSPLIT_2G for ast2400 platforms, required for mtd driver

----------------------------------------------------------------
C?dric Le Goater (1):
      ARM: configs: aspeed: Update Aspeed G4 with VMSPLIT_2G

Joel Stanley (1):
      ARM: config: aspeed: Add I2C, VUART, LPC Snoop

 arch/arm/configs/aspeed_g4_defconfig | 5 ++++-
 arch/arm/configs/aspeed_g5_defconfig | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)
