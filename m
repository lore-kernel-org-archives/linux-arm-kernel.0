From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 16 May 2013 16:34:04 +0100
Subject: [PATCH 0/3] ARM: kernel: cpu_logical_map misc fixes
Message-ID: <1368718447-19209-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Rob,

this series contains simple fixes/improvements related to the DT
cpu_logical_map initialization code. I would like to get these patches
in in order to have a stable base on top of which I can send the DT topology
bindings and cpu_logical_map bindings/parsing code updates for arm and arm64.

Thank you very much,
Lorenzo

Lorenzo Pieralisi (3):
  ARM: DT: kernel: move temporary cpu map stack array to static data
  ARM: kernel: fix arm_dt_init_cpu_maps() to skip non-cpu nodes
  ARM: kernel: fix __cpu_logical_map default initialization

 arch/arm/include/asm/cputype.h  |  2 ++
 arch/arm/include/asm/smp_plat.h |  2 +-
 arch/arm/kernel/devtree.c       | 14 ++++++++++----
 arch/arm/kernel/setup.c         |  2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)

-- 
1.8.2.2
