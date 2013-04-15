From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Apr 2013 14:41:49 -0400
Subject: [GIT PULL 3/4] mvebu boards for v3.10
Message-ID: <20130415184149.GQ28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:

  Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/boards-3.10

for you to fetch changes up to d3dde4df4483cefc614317a2ae550b20ef29f58c:

  ARM: Kirkwood: update Network Space Mini v2 description (2013-04-10 18:16:25 +0000)

----------------------------------------------------------------
mvebu boards for v3.10

 - kirkwood
    - Netgear ReadyNAS Duo v2
    - add guruplug dt to defconfig
    - Lacie Cloudbox

----------------------------------------------------------------
Arnaud Ebalard (1):
      ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2 using DT

Sebastian Hesselbarth (1):
      ARM: kirkwood: add MACH_GURUPLUG_DT to defconfig

Simon Guinot (3):
      ARM: Kirkwood: sort board entries by ASCII-code order
      ARM: Kirkwood: DT board setup for CloudBox
      ARM: Kirkwood: update Network Space Mini v2 description

 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |  89 ++++++
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 180 +++++++++++
 arch/arm/boot/dts/kirkwood-ns2mini.dts             |   1 +
 arch/arm/configs/kirkwood_defconfig                |  53 ++--
 arch/arm/mach-kirkwood/Kconfig                     | 334 +++++++++++----------
 arch/arm/mach-kirkwood/Makefile                    |  42 +--
 arch/arm/mach-kirkwood/board-dt.c                  |  18 +-
 arch/arm/mach-kirkwood/board-ns2.c                 |   3 +-
 arch/arm/mach-kirkwood/board-readynas.c            |  28 ++
 arch/arm/mach-kirkwood/common.h                    |  12 +
 11 files changed, 555 insertions(+), 209 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-cloudbox.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
 create mode 100644 arch/arm/mach-kirkwood/board-readynas.c
