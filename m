From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 16:03:58 -0400
Subject: [GIT PULL] ARM: mvebu: boards for v3.11 (round 1)
Message-ID: <20130520200358.GK31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/boards-3.11-1

for you to fetch changes up to 193da78bec1b510ab0a743348a7e9a2c24766268:

  ARM: Kirkwood: add DT support for Sheevaplug and Sheevaplug eSATA (2013-05-15 00:33:18 +0000)

----------------------------------------------------------------
mvebu boards for v3.11 (round 1)

 - kirkwood: add sheevaplug and sheevaplug eSATA

----------------------------------------------------------------
Simon Baatz (1):
      ARM: Kirkwood: add DT support for Sheevaplug and Sheevaplug eSATA

 arch/arm/mach-kirkwood/Kconfig            |  7 +++++++
 arch/arm/mach-kirkwood/Makefile           |  1 +
 arch/arm/mach-kirkwood/board-dt.c         |  4 ++++
 arch/arm/mach-kirkwood/board-sheevaplug.c | 27 +++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h           |  5 +++++
 5 files changed, 44 insertions(+)
 create mode 100644 arch/arm/mach-kirkwood/board-sheevaplug.c
