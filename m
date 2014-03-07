From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  6 Mar 2014 19:44:09 -0700
Subject: [GIT PULL 1/2] ARM: bcm2835: consolidate into mach-bcm/
Message-ID: <1394160250-3939-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pull request consists of a single patch which moves files from
arch/arm/mach-bcm2835 into mach-bcm, thus consolidating them with
support for other Broadcom chips.

----------------------------------------------------------------

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.15-soc

for you to fetch changes up to d30fe6272183f3cc8b9f3f111cd36271332e4cec:

  ARM: bcm2835: Move to mach-bcm directory

----------------------------------------------------------------

Markus Mayer (1):
      ARM: bcm2835: Move to mach-bcm directory

 MAINTAINERS                                         |  2 +-
 arch/arm/Kconfig                                    |  2 --
 arch/arm/Makefile                                   |  1 -
 arch/arm/configs/bcm2835_defconfig                  |  1 +
 arch/arm/mach-bcm/Kconfig                           | 16 ++++++++++++++++
 arch/arm/mach-bcm/Makefile                          |  2 ++
 .../bcm2835.c => mach-bcm/board_bcm2835.c}          |  0
 arch/arm/mach-bcm2835/Kconfig                       | 15 ---------------
 arch/arm/mach-bcm2835/Makefile                      |  1 -
 9 files changed, 20 insertions(+), 20 deletions(-)
 rename arch/arm/{mach-bcm2835/bcm2835.c => mach-bcm/board_bcm2835.c} (100%)
 delete mode 100644 arch/arm/mach-bcm2835/Kconfig
 delete mode 100644 arch/arm/mach-bcm2835/Makefile
