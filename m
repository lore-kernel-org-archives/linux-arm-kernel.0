From: neilb@suse.de (NeilBrown)
Date: Sun, 19 Feb 2012 13:29:31 +1100
Subject: [PATCH 0/2] Two trivial omap/serial patches
Message-ID: <20120219022841.8254.86264.stgit@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a couple of small clean-ups following the recent major changes.

Thanks,
NeilBrown

---

NeilBrown (2):
      ARM: OMAP2: remove some orphan function declarations.
      ARM: OMAP2+: UART: remove unused fields in omap_uart_state.


 arch/arm/mach-omap2/pm.h                 |    1 -
 arch/arm/mach-omap2/serial.c             |    4 ----
 arch/arm/plat-omap/include/plat/serial.h |    1 -
 3 files changed, 0 insertions(+), 6 deletions(-)

-- 
Signature
