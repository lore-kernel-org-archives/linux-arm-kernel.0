From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 31 Jul 2015 11:28:14 +0200
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.3 #2
Message-ID: <55BB3FAE.1020907@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for cleanup for mvebu for v4.3

Gregory

The following changes since commit 7e5308be4c0747e328d03f3daa46aaa5eaf7714f:

  ARM: mvebu: update EEPROM description of Armada 388 GP (2015-07-09 15:28:08 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.3-2

for you to fetch changes up to dc57844a736f10bf3799d63d7c0d0efc29b1ad7d:

  ARM: dts: orion5x: add buffalo linkstation ls-wtgl (2015-07-25 16:19:20 +0200)

----------------------------------------------------------------
mvebu dt changes for v4.3 (part #2)

Add support Buffalo Linkstation LS-WTGL

----------------------------------------------------------------
Roger Shimizu (1):
      ARM: dts: orion5x: add buffalo linkstation ls-wtgl

 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 273 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 274 insertions(+)
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
