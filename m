From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 12 Mar 2012 05:01:48 -0600 (MDT)
Subject: [GIT PULL] ARM: OMAP2+: hwmod/PRM: miscellaneous patches for 3.4
Message-ID: <alpine.DEB.2.00.1203120500260.11332@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:

  Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 misc_devel_3.4

for you to fetch changes up to 553e322282655f213d131903ce7019aa25880273:

  ARM: OMAP4: prm: fix interrupt register offsets (2012-03-12 04:30:02 -0600)


- Paul
----------------------------------------------------------------
Rajendra Nayak (1):
      ARM: OMAP: hwmod: Use sysc_fields->srst_shift and get rid of hardcoded SYSC_TYPE2_SOFTRESET_MASK

Tero Kristo (1):
      ARM: OMAP4: prm: fix interrupt register offsets

 arch/arm/mach-omap2/omap_hwmod.c |    8 +++++---
 arch/arm/mach-omap2/prm44xx.c    |   21 +++++++++++----------
 2 files changed, 16 insertions(+), 13 deletions(-)
