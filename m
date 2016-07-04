From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 04 Jul 2016 22:48:39 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.7 (#2)
Message-ID: <8737npw2mw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for fixes for mvebu for v4.7.

Gregory

The following changes since commit 929e604efa3dc0522214e0dc18984be23993e9f0:

  ARM: dts: armada-38x: fix MBUS_ID for crypto SRAM on Armada 385 Linksys (2016-06-16 17:01:28 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.7-2

for you to fetch changes up to b44439e42912b9dcc510a0ff891809ea2cadc46b:

  ARM: mvebu: compile pm code conditionally (2016-06-30 13:47:52 +0200)

----------------------------------------------------------------
mvebu fixes for 4.7 (part 2)

Fix a regression introduced by a cleanup on kirkwood_pm_init

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: mvebu: compile pm code conditionally

 arch/arm/mach-mvebu/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
