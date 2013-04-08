From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 Apr 2013 15:19:44 +0200
Subject: [GIT PULL] ux500 pinctrl patches
Message-ID: <CACRpkdbJ=T_-P0+gCuajMNCM9XGWQsa1EfzfOpV4Dwdf-wYRXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

here are some ux500 pinctrl patches for the next merge cycle.
Please pull it in to some apropriate ux500 branch.

Yours,
Linus Walleij

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-pinctrl

for you to fetch changes up to 44df39f28a1a163b179f0374ff915b556bc56105:

  ARM: ux500: 8500: add ab8500-musb pinctrl support (2013-04-03 22:51:39 +0200)

----------------------------------------------------------------
ux500 pinctrl updates for the ARM SoC tree.

----------------------------------------------------------------
Fabio Baltieri (1):
      ARM: ux500: remove redundant DB8500_PIN_SLEEP definition

Julien Delacou (1):
      ARM: ux500: u8500: fix pinctrl IDLE state definition for SPI2

Lee Jones (1):
      ARM: ux500: Add Snowball pin configuration for user LED

Patrice Chotard (1):
      ARM: ux500: 8500: add ab8500-musb pinctrl support

 arch/arm/mach-ux500/board-mop500-pins.c | 34 +++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)
