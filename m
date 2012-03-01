From: tony@atomide.com (Tony Lindgren)
Date: Thu, 01 Mar 2012 09:42:12 -0800
Subject: [PATCH 0/2] Few more omap DT patches for next merge window
Message-ID: <20120301174037.12471.72457.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Looks like we need one fix to what's currently queued up in
dt-part2 branch for omaps. And we can make board-generic more
readable by cutting down the ifdefs.

Regards,

Tony

---

Tony Lindgren (2):
      ARM: OMAP2+: Fix build error when only ARCH_OMAP2/3 or 4 is selected
      ARM: OMAP2+: Remove extra ifdefs for board-generic


 arch/arm/mach-omap2/board-generic.c |   83 ++++++++++++++++-------------------
 1 files changed, 39 insertions(+), 44 deletions(-)

-- 
Signature
