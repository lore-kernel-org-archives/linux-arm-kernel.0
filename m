From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Jun 2017 17:12:40 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.12 (#2)
Message-ID: <87shiu3d7b.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for fixes for mvebu for v4.12.

Gregory

The following changes since commit 44f73dc42c11398d7b84e94365a485ebd6420798:

  arm64: marvell: dts: fix interrupts in 7k/8k crypto nodes (2017-05-24 17:12:59 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.12-2

for you to fetch changes up to 4fcee14d3802b60f22baf1aeab9f1cff08834c56:

  ARM: dts: kirkwood: Fix Openblock A6 nand partition overlap (2017-06-17 09:08:47 +0200)

----------------------------------------------------------------
mvebu fixes for 4.12 (part 2)

Fix Openblock A6 (kirkwood base board) nand partition overlap

----------------------------------------------------------------
Peter Korsgaard (1):
      ARM: dts: kirkwood: Fix Openblock A6 nand partition overlap

 arch/arm/boot/dts/kirkwood-openblocks_a6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
