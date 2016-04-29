From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Apr 2016 16:33:55 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.7 (#1)
Message-ID: <87twikscvg.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc for mvebu for v4.7.

Gregory

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.7-1

for you to fetch changes up to 3a1a4559624a51e1f4ed8954d546ccc7367bb8d4:

  ARM: dove: Remove CLK_IS_ROOT (2016-04-27 13:55:52 +0200)

----------------------------------------------------------------
mvebu soc for 4.7

- Clock framework cleanup with the "Remove CLK_IS_ROOT" series

----------------------------------------------------------------
Stephen Boyd (3):
      ARM: mv78xx0: Remove CLK_IS_ROOT
      ARM: orion5x: Remove CLK_IS_ROOT
      ARM: dove: Remove CLK_IS_ROOT

 arch/arm/mach-dove/common.c    | 3 +--
 arch/arm/mach-mv78xx0/common.c | 3 +--
 arch/arm/mach-orion5x/common.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)
