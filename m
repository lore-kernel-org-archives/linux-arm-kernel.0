From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 16 Jul 2016 12:53:46 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.8 (#1)
Message-ID: <878tx1svk5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.8.

Gregory

The following changes since commit c134043ed396b06addf5866d977fed7ba6a393a9:

  ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500 (2016-04-14 19:06:50 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.8-1

for you to fetch changes up to d261861ab52623e34a25fe6ae76714456edda033:

  ARM: dts: armada-388-clearfog: remove duplicate mdio entry (2016-07-11 18:05:48 +0200)

----------------------------------------------------------------
mvebu dt for 4.8 (part 1)

Fix dts for the clearfog board (Armada 388 SoC based)

----------------------------------------------------------------
Russell King (1):
      ARM: dts: armada-388-clearfog: remove duplicate mdio entry

 arch/arm/boot/dts/armada-388-clearfog.dts | 16 ----------------
 1 file changed, 16 deletions(-)
