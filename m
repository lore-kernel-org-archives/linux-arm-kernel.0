From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 14:38:22 -0400
Subject: [GIT PULL] ARM: mvebu: boards for v3.11 (round 2 cumulative)
Message-ID: <20130528183822.GC31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/boards-3.11-2

for you to fetch changes up to 391a16c7783a64309dc930c6d454372d7a8beb12:

  ARM: Kirkwood: Convert LSXL to restart-poweroff driver. (2013-05-26 01:12:34 +0000)

----------------------------------------------------------------
mvebu board changes for v3.11 (round 2)

 - kirkwood
    - QNAP use power-off driver
    - LSXL use restart-poweroff driver

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: Kirkwood: Make use of the QNAP Power off driver.
      ARM: Kirkwood: Convert LSXL to restart-poweroff driver.

Simon Baatz (1):
      ARM: Kirkwood: add DT support for Sheevaplug and Sheevaplug eSATA

 arch/arm/boot/dts/kirkwood-lsxl.dtsi      |  4 ++++
 arch/arm/boot/dts/kirkwood-ts219.dtsi     |  5 +++++
 arch/arm/mach-kirkwood/Kconfig            |  9 +++++++++
 arch/arm/mach-kirkwood/Makefile           |  1 +
 arch/arm/mach-kirkwood/board-dt.c         |  4 ++++
 arch/arm/mach-kirkwood/board-lsxl.c       | 16 ----------------
 arch/arm/mach-kirkwood/board-sheevaplug.c | 27 +++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/board-ts219.c      |  3 ---
 arch/arm/mach-kirkwood/common.h           |  5 +++++
 9 files changed, 55 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/board-sheevaplug.c
