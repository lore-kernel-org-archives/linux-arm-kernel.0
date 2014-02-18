From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 18 Feb 2014 11:11:02 -0500
Subject: [GIT PULL] ARM: mvebu: DT fixes for v3.14
Message-ID: <20140218161102.GT7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I've been sitting on the missing alias for a while waiting for more DT
fixes to show up.  Well, finally one did. :(

Please pull for v3.14.

I intend to re-add the dove PMU node once I know for certain the
corresponding driver is going in to v3.15 (pull request already sent).

thx,

Jason.

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-fixes-3.14

for you to fetch changes up to ae10f8329f9b22d650aa12307b260eba2bc0c571:

  ARM: dove: dt: revert PMU interrupt controller node (2014-02-18 16:01:27 +0000)

----------------------------------------------------------------
mvebu dt fixes for v3.14

 - mvebu: add missing 'eth3' alias for mv78260

 - dove: revert PMU interrupt controller node, wait for driver to land.

----------------------------------------------------------------
Jason Cooper (1):
      ARM: dove: dt: revert PMU interrupt controller node

Willy Tarreau (1):
      ARM: mvebu: dt: add missing alias 'eth3' on Armada XP mv78260

 arch/arm/boot/dts/armada-xp-mv78260.dtsi |  3 ++-
 arch/arm/boot/dts/dove.dtsi              | 11 -----------
 2 files changed, 2 insertions(+), 12 deletions(-)
