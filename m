From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 04 Mar 2014 14:07:31 -0700
Subject: [PATCH 0/2] sched: Removed unused mc_capable() and smt_capable()
Message-ID: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just cleanup of a couple unused interfaces and (for sparc64) a
supporting variable.

---

Bjorn Helgaas (2):
      sched: Remove unused mc_capable() and smt_capable()
      sparc64: Remove unused sparc64_multi_core


 arch/arm/include/asm/topology.h      |    3 ---
 arch/ia64/include/asm/topology.h     |    1 -
 arch/mips/include/asm/topology.h     |    4 ----
 arch/powerpc/include/asm/topology.h  |    1 -
 arch/sparc/include/asm/smp_64.h      |    1 -
 arch/sparc/include/asm/topology_64.h |    2 --
 arch/sparc/kernel/mdesc.c            |    4 ----
 arch/sparc/kernel/prom_64.c          |    3 ---
 arch/sparc/kernel/smp_64.c           |    2 --
 arch/x86/include/asm/topology.h      |    6 ------
 10 files changed, 27 deletions(-)
