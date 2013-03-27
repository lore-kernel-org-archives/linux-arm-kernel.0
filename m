From: stigge@antcom.de (Roland Stigge)
Date: Wed, 27 Mar 2013 10:18:37 +0100
Subject: [GIT PULL] ARM: LPC32xx: defconfig update
Message-ID: <5152B96D.8020103@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this is the defconfig update for 3.10.

The signed tag is lpc32xx-defconfig-for-3.10

The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:

  Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/defconfig

for you to fetch changes up to 17e7979f83c1de305fa81efb0aa7a3a56bd8121c:

  ARM: LPC32xx: defconfig update: Cleanup (EXPERIMENTAL) (2013-03-27 09:37:01 +0100)

----------------------------------------------------------------
ARM: LPC32xx: defconfig update

This is the defconfig update series for 3.10, including 4 non-critical patches.

----------------------------------------------------------------
Artem Bityutskiy (1):
      ARM: LPC32xx: defconfig update: Remove the museum NAND option

Roland Stigge (3):
      ARM: LPC32xx: defconfig update: gpio and keys
      ARM: LPC32xx: defconfig update: Default drivers and cleanup
      ARM: LPC32xx: defconfig update: Cleanup (EXPERIMENTAL)

 arch/arm/configs/lpc32xx_defconfig |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)
