From: nm@ti.com (Nishanth Menon)
Date: Fri, 18 May 2012 14:33:18 -0500
Subject: [PATCH 0/3] ARM: OMAP3+: VP: collate fixes
In-Reply-To: <[PATCH] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
References: <[PATCH] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
Message-ID: <1337369601-14915-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewing the android code base brought out a few fixes that upstream
does not have, so collating them and posting them out in this chain.

Nishanth Menon (2):
  ARM: OMAP3+: PM: VP: check to ensure VP is idle before forceupdate
  ARM: OMAP3+: PM: VP: check only the VPINIDLE status bit

Wenbiao Wang (1):
  ARM: OMAP3+: PM: VP: ensure VP is idle before disable

 arch/arm/mach-omap2/vp.c          |   34 ++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/vp.h          |    3 ++-
 arch/arm/mach-omap2/vp3xxx_data.c |    1 +
 arch/arm/mach-omap2/vp44xx_data.c |    1 +
 4 files changed, 34 insertions(+), 5 deletions(-)

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Regards,
Nishanth Menon
-- 
1.7.9.5
