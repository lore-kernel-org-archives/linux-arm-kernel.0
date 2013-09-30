From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Sep 2013 11:42:08 -0400
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.13
Message-ID: <20130930154208.GG31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

These are the SoC changes that didn't make it during the last merge
window.  As with mvebu/drivers, these have been in -next since 3.12-rc1
without issue.

thx,

Jason.


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/soc-3.13

for you to fetch changes up to ffe195c369656b5e4d3b5c21376483c23589be30:

  ARM: dove: remove legacy pcie and clock init (2013-09-30 15:01:51 +0000)

----------------------------------------------------------------
mvebu soc changes for v3.13

 - dove
    - use DT for mbus windows
    - use DT for pcie and clock init

----------------------------------------------------------------
Sebastian Hesselbarth (2):
      ARM: dove: switch to DT probed mbus address windows
      ARM: dove: remove legacy pcie and clock init

 arch/arm/mach-dove/board-dt.c | 39 +--------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)
