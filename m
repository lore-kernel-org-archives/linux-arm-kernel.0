From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jul 2016 16:12:56 +0200
Subject: [GIT PULL] ARM: mvebu: dt-late for v4.8
Message-ID: <87popznp93.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a late pull request for a device tree fix on mvebu for v4.8.

If it is too late to have it for v4.8-rc1, I will send it again as fix
for v4.8-rc2.

Thanks,

Gregory

The following changes since commit d261861ab52623e34a25fe6ae76714456edda033:

  ARM: dts: armada-388-clearfog: remove duplicate mdio entry (2016-07-11 18:05:48 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-late-4.8

for you to fetch changes up to 1f5b6fd2942ca2a063655fbeea5a922bc08f9e21:

  ARM: dts: armada388-clearfog: number LAN ports properly (2016-07-27 15:12:02 +0200)

----------------------------------------------------------------
Late mvebu dt for v4.8

The commit correct the led name on the clearfog board and should be
applied as soon as possible to avoid spread the port renumbering over
a large range of kernels.

----------------------------------------------------------------
Russell King (1):
      ARM: dts: armada388-clearfog: number LAN ports properly

 arch/arm/boot/dts/armada-388-clearfog.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
