From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 23 Apr 2011 05:17:25 +0200
Subject: AT91 pull request
Message-ID: <20110423031725.GE23775@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	This is bug fixes and one old patch that just add the 5series chip id only
	needed by drivers
	the soc full support will be delayed until the current work on the cleannup
	of at91 will be weel advanced

	Could you pull

The following changes since commit 0f1d9f78ce41a8874d30271ef8480e6f8f7f1fce:

  Merge branch 'tty-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty-2.6 (2011-04-22 16:19:19 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-2.6-at91.git for-linus

Greg Ungerer (2):
      arm: at91: minimal defconfig for at91x40 SoC
      arm: at91: fix compiler warning for eb01 board build

Jean-Christophe PLAGNIOL-VILLARD (1):
      at91: Add ARCH_ID and basic cpu macros definition for 5series chips family.

Uwe Kleine-K?nig (1):
      ARM: at91: AT91CAP9 has a macb device

 arch/arm/configs/at91x40_defconfig    |   48 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Kconfig            |    1 +
 arch/arm/mach-at91/board-eb01.c       |    7 ++++-
 arch/arm/mach-at91/include/mach/cpu.h |   28 +++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/configs/at91x40_defconfig

Best Regards,
J & nico.
