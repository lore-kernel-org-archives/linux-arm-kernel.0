From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Apr 2017 15:30:56 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.11 (#1)
Message-ID: <87tw614q9b.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.11.

Gregory

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.11-1

for you to fetch changes up to d43e85b7d7c759a01f92fa09bba5d6eb6e406795:

  ARM: orion5x: only call into phylib when available (2017-03-30 17:30:39 +0200)

----------------------------------------------------------------
mvebu fixes for 4.11 (part 1)

Fix build of the board code for orion5x when some parts are configured
as module.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: orion5x: only call into phylib when available

 arch/arm/mach-orion5x/Kconfig | 1 +
 arch/arm/plat-orion/common.c  | 5 +++++
 2 files changed, 6 insertions(+)
