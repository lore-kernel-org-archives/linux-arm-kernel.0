From: nm@ti.com (Nishanth Menon)
Date: Mon,  3 Jan 2011 12:58:28 -0600
Subject: [PATCH 0/2] OMAP: TWL: sparse fixes
Message-ID: <1294081110-23695-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Source:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
branch: omap-for-linus

Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
resulted in the following sparse warnings:
http://pastebin.mozilla.org/907954

This series fixes the twl warnings
Nishanth Menon (2):
  OMAP2+: TWL: make conversion routines static
  OMAP2+: TWL: include pm header for init protos

 arch/arm/mach-omap2/omap_twl.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Regards,
Nishanth Menon
