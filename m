From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Mar 2011 12:34:13 -0800
Subject: [PATCH 0/2] omap2+: Few mux patches
Message-ID: <20110311203317.26901.67180.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few omap mux related patches for review.

Regards,

Tony

---

Tony Lindgren (2):
      omap2+: mux: Fix compile when CONFIG_OMAP_MUX is not selected
      omap4: mux: Remove duplicate mux modes


 arch/arm/mach-omap2/board-cm-t35.c     |    2 
 arch/arm/mach-omap2/board-cm-t3517.c   |    2 
 arch/arm/mach-omap2/board-devkit8000.c |    2 
 arch/arm/mach-omap2/mux44xx.c          |  282 +-------------------------------
 4 files changed, 12 insertions(+), 276 deletions(-)

-- 
Signature
