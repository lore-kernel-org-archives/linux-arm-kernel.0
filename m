From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 13 Jul 2018 11:28:50 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.19 (#1)
Message-ID: <87va9jbi25.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.19.

Gregory

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.19-1

for you to fetch changes up to 4436a3711e3249840e0679e92d3c951bcaf25515:

  arm64: dts: marvell: armada-37xx: reserve memory for ATF (2018-06-29 16:39:03 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.19 (part 1)

Armada 3700
 - Add default memory reservation for ATF
 - Add a node for AVS support
Fix eth3 connector name on the Macchiatobin

----------------------------------------------------------------
Baruch Siach (1):
      arm64: dts: marvell: mcbin: fix eth3 connector name

Gregory CLEMENT (1):
      arm64: dts: marvell: armada-37xx: add the node allowing AVS support

Victor Gu (1):
      arm64: dts: marvell: armada-37xx: reserve memory for ATF

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)
