From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 31 Jul 2015 11:16:35 +0200
Subject: [GIT PULL] ARM: mvebu: soc changes for v4.3
Message-ID: <55BB3CF3.7050000@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc change for mvebu for v4.3

Gregory

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.3-1

for you to fetch changes up to 482d638f98cc626bf01d4c9f6d6d35fc77d630c8:

  ARM: mvebu: Warn about the wake-up sources not taken into account in suspend (2015-07-28 11:40:47 +0200)

----------------------------------------------------------------
mvebu soc changes for v4.3 (part #1)

- Extend suspend to RAM support in order to add new mvebu SoC
- Add standby support for all Armada 3xx/XP SoCs

----------------------------------------------------------------
Gregory CLEMENT (3):
      ARM: mvebu: Use __init for the PM initialization functions
      ARM: mvebu: Add standby support
      ARM: mvebu: Warn about the wake-up sources not taken into account in suspend

Nadav Haklai (1):
      ARM: mvebu: prepare set_cpu_coherent() for future extension

Thomas Petazzoni (3):
      ARM: mvebu: do not check machine in mvebu_pm_init()
      ARM: mvebu: prepare mvebu_pm_store_bootinfo() to support multiple SoCs
      ARM: mvebu: prepare pm-board.c for the introduction of Armada 38x support

 arch/arm/mach-mvebu/coherency.c | 29 +++++++++++++++++------------
 arch/arm/mach-mvebu/common.h    |  4 ++--
 arch/arm/mach-mvebu/pm-board.c  | 30 +++++++++++++++++++-----------
 arch/arm/mach-mvebu/pm.c        | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 4 files changed, 103 insertions(+), 39 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
