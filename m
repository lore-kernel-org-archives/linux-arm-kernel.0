From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 14:25:39 +0200
Subject: [GIT PULL 3/5]: ux500 pinctrl changes for v3.11
Message-ID: <CACRpkdbFs=pX+Yc8EzgVyi-k5HypkHO9jMGMU+VkYfRYyinDSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this is the ux500 pin control changes for v3.11. See the signed
tag for details.

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-pinctrl-for-arm-soc

for you to fetch changes up to 8258b187c2ba91ba1ff276fd0413f5b655824247:

  ARM: ux500: add ABx500 pinctrl tables (2013-05-31 16:30:38 +0200)

----------------------------------------------------------------
Ux500 pinctrl changes:
- Updates to MSP pinctrl entry for ALSA SoC
- ABx500 pinctrl tables

----------------------------------------------------------------
Fabio Baltieri (1):
      ARM: ux500: update MSP1 pinctrl defintions

Patrice Chotard (1):
      ARM: ux500: add ABx500 pinctrl tables

 arch/arm/mach-ux500/board-mop500-pins.c | 279 ++++++++++++++++++++++++++++++--
 1 file changed, 268 insertions(+), 11 deletions(-)
