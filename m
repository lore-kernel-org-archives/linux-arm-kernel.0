From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Aug 2015 03:08:45 -0700
Subject: [GIT PULL 1/2] omap soc fix for v4.3 merge window
Message-ID: <pull-1439455019-336197>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 24da741c678f865de3182194604dbddcc7fc7f3c:

  Merge branch 'dm814x-soc' into omap-for-v4.3/soc (2015-07-23 21:59:18 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/soc-pt2

for you to fetch changes up to ed293d1ad2b0c28b6abc3bd728b07754bc00f1cd:

  memory: kill off set_irq_flags usage (2015-08-13 00:48:52 -0700)

----------------------------------------------------------------
Fix omap PM regression in Linux next and kill set_irq_flags usage
for GPMC.

----------------------------------------------------------------
Rob Herring (1):
      memory: kill off set_irq_flags usage

Tony Lindgren (1):
      ARM: OMAP2+: Fix power domain operations regression caused by 81xx

 arch/arm/mach-omap2/powerdomains3xxx_data.c | 6 +++++-
 drivers/memory/omap-gpmc.c                  | 5 ++---
 2 files changed, 7 insertions(+), 4 deletions(-)
