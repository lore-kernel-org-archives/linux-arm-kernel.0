From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 29 Sep 2010 09:38:55 +0900
Subject: [PATCH v2 0/3] ARM: S5PC100/S5PC110/S5PC210: Sort out
	the	configuration
Message-ID: <20100929003855.GA486@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 32163f4b2cef28a5aab8b226ffecfc6379a53786:
  Al Viro (1):
        alpha: fix usp value in multithreaded coredumps

Kyungmin Park (3):
      ARM: S5PC110: Place the common SPARSEMEM at ARCH_S5PV210
      ARM: S5PC210: Place the common SPARSEMEM at ARCH_S5PV310
      ARM: S5PC100/S5PC110/S5PC210: Selete PLAT_S5P at each ARCH_S5P series

 arch/arm/Kconfig              |    5 +++++
 arch/arm/mach-s5pc100/Kconfig |    1 -
 arch/arm/mach-s5pv210/Kconfig |    5 -----
 arch/arm/mach-s5pv310/Kconfig |    3 ---
 4 files changed, 5 insertions(+), 9 deletions(-)
