From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 23 May 2013 12:49:56 +0100
Subject: [GIT PULL] ARM cpu logical map init updates
Message-ID: <20130523114956.GA3872@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

following the pull request for DT cpus/cpu bindings for arm/arm64
updates and relative dts files updates:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170234.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170242.html

please pull the arm core code patches that enable the parsing of the
new bindings. First two patches are two fixes, the first aimed also at
the stable kernel, as marked in the commit log.

Thank you very much indeed,
Lorenzo

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-lp.git dt-init-map-updates

for you to fetch changes up to 1b4a70726dfafb82ebedc017bf02c20edaf5dd29:

  ARM: DT: kernel: DT cpus/cpu node bindings update (2013-05-23 12:35:51 +0100)

----------------------------------------------------------------
Lorenzo Pieralisi (3):
      ARM: kernel: fix arm_dt_init_cpu_maps() to skip non-cpu nodes
      ARM: kernel: fix __cpu_logical_map default initialization
      ARM: DT: kernel: DT cpus/cpu node bindings update

 arch/arm/include/asm/cputype.h  |   2 +
 arch/arm/include/asm/smp_plat.h |   2 +-
 arch/arm/kernel/devtree.c       | 149 ++++++++++++++++++++++++----------------
 arch/arm/kernel/setup.c         |   2 +-
 4 files changed, 95 insertions(+), 60 deletions(-)
