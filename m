From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 09 Mar 2015 20:42:28 +0100
Subject: [GIT PULL] ARM: mvebu: cleanup changes for v4.1
Message-ID: <54FDF7A4.4030401@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for cleanup for mvebu for v4.1

Gregory

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-cleanup-4.1

for you to fetch changes up to bc2d7a58b9a48e4c1f35fadb30223ca87c59d50f:

  ARM: mvebu: add __initconst specifiers on DT_MACHINE_START dt_compat tables (2015-03-04 14:56:21 +0100)

----------------------------------------------------------------
mvebu clean-up changes for v4.1 (part #1)

- Constify the dt_compat table in DT_MACHINE_START

----------------------------------------------------------------
Thomas Petazzoni (1):
      ARM: mvebu: add __initconst specifiers on DT_MACHINE_START dt_compat tables

 arch/arm/mach-mvebu/board-v7.c | 6 +++---
 arch/arm/mach-mvebu/dove.c     | 2 +-
 arch/arm/mach-mvebu/kirkwood.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
