From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Feb 2014 11:36:28 -0500
Subject: [GIT PULL] ARM: mvebu soc changes for v3.15
Message-ID: <20140218163628.GW7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

A small round of changes that have been sitting in -next for a week or
so.  Please pull.

thx,

Jason.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.15

for you to fetch changes up to 08bb3adfd3adeb4653095e7968b6a46cef940404:

  ARM: mvebu: remove unneeded ->map_io field for Armada 370/XP (2014-02-11 19:33:04 +0000)

----------------------------------------------------------------
mvebu soc changes for v3.15

 - mvebu
    - Makefile cleanup and remove map_io
    - use of_find_matching_node_and_match

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: Makefile clean-up

Josh Cartwright (1):
      ARM: mvebu: make use of of_find_matching_node_and_match

Thomas Petazzoni (1):
      ARM: mvebu: remove unneeded ->map_io field for Armada 370/XP

 arch/arm/mach-mvebu/Makefile            | 3 +--
 arch/arm/mach-mvebu/armada-370-xp.c     | 6 ------
 arch/arm/mach-mvebu/system-controller.c | 9 ++++-----
 3 files changed, 5 insertions(+), 13 deletions(-)
