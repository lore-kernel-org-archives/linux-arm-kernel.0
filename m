From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Fri,  5 Jun 2015 14:39:11 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.2, part 2, version 2
Message-ID: <1433533151-6301-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

This is an updated pull request for the supend-to-ram patch that has the
EDAC code removed in order to avoid a merge conflict.

Thanks,
Dinh

The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f3d:

  Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_updates_for_v4.2_part2_v2

for you to fetch changes up to ae03cc09f379f1bd69cd0534fb2c40c087e7cea1:

  ARM: socfpga: support suspend to ram (2015-06-05 08:27:43 -0500)

----------------------------------------------------------------
SoCFPGA update for v4.2, part 2
- Add support for suspend to RAM

----------------------------------------------------------------
Alan Tull (1):
      ARM: socfpga: support suspend to ram

 arch/arm/mach-socfpga/Kconfig        |  10 ++-
 arch/arm/mach-socfpga/Makefile       |   1 +
 arch/arm/mach-socfpga/core.h         |   6 +-
 arch/arm/mach-socfpga/pm.c           | 149 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/self-refresh.S | 136 ++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c      |   6 +-
 6 files changed, 305 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/pm.c
 create mode 100644 arch/arm/mach-socfpga/self-refresh.S
