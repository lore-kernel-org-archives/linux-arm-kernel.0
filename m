From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Tue,  2 Jun 2015 21:11:33 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.2, part 2
Message-ID: <1433297493-3760-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof:

Please pull in this patch for v4.2.

Thanks,
Dinh

The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f3d:

  Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)

are available in the git repository at:

  git at gitolite.kernel.org:pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_updates_for_v4.2_part2

for you to fetch changes up to a6cb1af402026c44eec5760036715acad1077b56:

  ARM: socfpga: support suspend to ram (2015-06-02 14:05:22 -0500)

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
 drivers/edac/altera_edac.c           |  20 +++++
 7 files changed, 325 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/pm.c
 create mode 100644 arch/arm/mach-socfpga/self-refresh.S
