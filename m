From: mike@compulab.co.il (Mike Rapoport)
Date: Mon,  7 Feb 2011 10:10:51 +0200
Subject: [PATCH 0/2] ARM: tegra: add TrimSlice support
Message-ID: <cover.1297063443.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add basic support for TrimSlice platform.
The mach-types update is required until the updated machine registry
is merged, otherwise the kernel would not build.

The patches are also available at git repository 
  git://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux-tegra.git trimslice/upstream

The following changes since commit 8dbdea8444d303a772bceb1ba963f0e3273bfc5e:

  Merge branch 'ixp4xx' of git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux-2.6 (2011-02-06 12:05:58 -0800)

Mike Rapoport (2):
  ARM: update trimslice entry in the machine registry
  ARM: tegra: add TrimSlice board

 arch/arm/mach-tegra/Kconfig                  |    6 +
 arch/arm/mach-tegra/Makefile                 |    3 +
 arch/arm/mach-tegra/board-trimslice-pinmux.c |  145 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-trimslice.c        |  104 ++++++++++++++++++
 arch/arm/mach-tegra/board-trimslice.h        |   22 ++++
 arch/arm/tools/mach-types                    |    2 +-
 6 files changed, 281 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-trimslice-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-trimslice.c
 create mode 100644 arch/arm/mach-tegra/board-trimslice.h

-- 
1.7.3.1
