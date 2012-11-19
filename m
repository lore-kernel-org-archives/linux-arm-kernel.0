From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 19 Nov 2012 16:15:26 +0000
Subject: [GIT PULL] ARM: /proc/cpuinfo updates
Message-ID: <20121119161525.GA26148@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

please consider pulling /proc/cpuinfo updates in preparation for forthcoming
big.LITTLE heterogeneous multi-cluster systems on chip that will require
HW information to be printed for all CPUs in the system not just the one
reading the /proc/cpuinfo file.

Thank you very much indeed,
Lorenzo

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-lp.git bl-cpuinfo

for you to fetch changes up to b4b8f770eb10a1bccaf8aa0ec1956e2dd7ed1e0a:

  ARM: kernel: update cpuinfo to print all online CPUs features (2012-11-19 14:51:12 +0000)

----------------------------------------------------------------
Lorenzo Pieralisi (2):
      ARM: kernel: add MIDR to per-CPU information data
      ARM: kernel: update cpuinfo to print all online CPUs features

 arch/arm/include/asm/cpu.h |  1 +
 arch/arm/kernel/setup.c    | 70 +++++++++++++++++++++++-----------------------
 arch/arm/kernel/smp.c      |  1 +
 3 files changed, 37 insertions(+), 35 deletions(-)
