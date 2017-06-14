From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Jun 2017 03:32:44 -0700
Subject: [GIT PULL] clean-up for omap1 for v4.13
Message-ID: <pull-1497436330-710784>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/omap1-signed

for you to fetch changes up to 764e4ef0a8871339eeddaf27ccc47aeeea28b974:

  ARM: OMAP1: Fix a typo in a comment line (2017-06-06 23:54:13 -0700)

----------------------------------------------------------------
A series of omap1 changes for issues found by Coccinelle.

----------------------------------------------------------------
Markus Elfring (5):
      ARM: OMAP1: DMA: Improve a size determination in omap1_system_dma_init()
      ARM: OMAP1: DMA: Delete an error message for a failed memory allocation in omap1_system_dma_init()
      ARM: OMAP1: DMA: Delete an unnecessary return statement in omap1_show_dma_caps()
      ARM: OMAP1: Delete an error message for a failed memory allocation in omap1_dm_timer_init()
      ARM: OMAP1: Fix a typo in a comment line

 arch/arm/mach-omap1/dma.c   | 5 +----
 arch/arm/mach-omap1/timer.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)
