From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Mar 2013 10:14:05 +0100
Subject: [GIT PULL] defconfig changes for ux500
Message-ID: <CACRpkdZ18qhcRDA2nGAtkfGkUdqJ1yXHZoDdBvot4x_YKJmqDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

here are two defconfig patches for the ux500, enabling some stuff that is
used on deployed systems. I don't know if you want this to go into the -rcs
or the next release, you get to choose.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-defconfig-v3.10

for you to fetch changes up to 441e248c1de9819a68c5132c23c6c3cd6da0d89b:

  ARM: ux500: enable ux500 EXT4_FS and LBDAF support by default
(2013-03-18 14:44:06 +0100)

----------------------------------------------------------------
Defconfig updates for ux500:
- Turn on the "heartbeat" LED trigger used by Snowball
- Enable the EXT4_FS and LBDAF by default

----------------------------------------------------------------
Hongbo Zhang (1):
      ARM: ux500: enable ux500 EXT4_FS and LBDAF support by default

Lee Jones (1):
      ARM: ux500: Turn on the 'heartbeat' LED trigger

 arch/arm/configs/u8500_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
