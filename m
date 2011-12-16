From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 16 Dec 2011 01:21:01 -0700 (MST)
Subject: [GIT PULL] ARM: OMAP3: hwmod data fixes for 3.2-rc
Message-ID: <alpine.DEB.2.00.1112160120040.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 hwmod_data_fixes_3.2rc

Aaro Koskinen (1):
      ARM: OMAP: hwmod data: fix the panic on Nokia RM-680 during boot

Felipe Contreras (1):
      ARM: OMAP: hwmod data: fix iva and mailbox hwmods for OMAP 3

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)
