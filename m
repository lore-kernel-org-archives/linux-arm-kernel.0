From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 16:49:39 +0900
Subject: [PATCH v2 0/3] ARM: S5PC210: Use the CPU common L2 cache	configuration
Message-ID: <20100930074939.GA11790@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v1:
	Update the optimized L2 cache prefetch value

The following changes since commit
df423dc7f2a801b9a45d7c501a8eb5c529455ea1:
  Linus Torvalds (1):
        Merge branch 'upstream-linus' of git://git.kernel.org/.../jgarzik/libata-dev

Kyungmin Park (3):
      ARM: L2X0: Add prefetch offset
      ARM: S5PC210: Remove L2 cache init at board file
      ARM: S5PC210: Set the common L2 cache configurations

 arch/arm/include/asm/hardware/cache-l2x0.h  |    1 +
 arch/arm/mach-s5pv310/cpu.c                 |   19 +++++++++++++++++++
 arch/arm/mach-s5pv310/mach-smdkv310.c       |    3 ---
 arch/arm/mach-s5pv310/mach-universal_c210.c |    3 ---
 4 files changed, 20 insertions(+), 6 deletions(-)
