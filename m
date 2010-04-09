From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 09 Apr 2010 19:00:27 +0100
Subject: [PATCH] Updated SWP emulation patch
Message-ID: <20100409175628.5003.10282.stgit@e101986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I submitted the previous version of this patch back in January,
and received no further feedback on it. This version is brought
up to date with Linus's tree as of today, and contains a couple
of very minor fixes (Kconfig, logging) added. 

Could I send this version to the patch system?

---

Leif Lindholm (1):
      ARM: Add SWP/SWPB emulation for ARMv7 processors (v5)


 Documentation/arm/00-INDEX      |    2 
 Documentation/arm/swp_emulation |   27 ++++
 arch/arm/kernel/Makefile        |    1 
 arch/arm/kernel/swp_emulate.c   |  260 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig             |   21 +++
 arch/arm/mm/proc-v7.S           |    6 +
 6 files changed, 317 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/swp_emulation
 create mode 100644 arch/arm/kernel/swp_emulate.c

-- 
Signature
