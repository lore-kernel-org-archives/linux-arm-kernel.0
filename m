From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Oct 2015 19:56:55 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.4 (#2)
Message-ID: <87r3kug0ig.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.4.

Gregory

The following changes since commit 9b24a35cb59888194706825b9c5ac550b0880277:

  ARM: mvebu: modify Orion and Kirkwoord crypto compatible strings (2015-10-09 17:08:02 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.4-2

for you to fetch changes up to 6b61f2497852b7d27e1c024d966c09defbf99948:

  ARM: mvebu: set SW polling as SDHCI card detection on A388-GP (2015-10-16 19:17:57 +0200)

----------------------------------------------------------------
mvebu dt for 4.4 (part 2)

- Add support for severals Armada-370-based Seagate NAS
- Fix Ready NAS device tree
- Modify SDHCI binding for A388-GP allowing using it on old and new
  version of the board

----------------------------------------------------------------
Arnaud Ebalard (2):
      arm: mvebu: disable unused Armada RTC on ReadyNAS 102, 104 and 2120
      arm: mvebu: reorder nodes under internal-regs by address in RN2120 .dts file

Marcin Wojtas (1):
      ARM: mvebu: set SW polling as SDHCI card detection on A388-GP

Simon Guinot (1):
      ARM: mvebu: add DT support for Seagate Personal Cloud

Vincent Donnefort (1):
      ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay

 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |   6 +
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   6 +
 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts  |  36 ++++
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  | 133 ++++++++++++
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi | 231 +++++++++++++++++++++
 .../dts/armada-370-seagate-personal-cloud-2bay.dts |  51 +++++
 .../boot/dts/armada-370-seagate-personal-cloud.dts |  37 ++++
 .../dts/armada-370-seagate-personal-cloud.dtsi     | 178 ++++++++++++++++
 arch/arm/boot/dts/armada-388-gp.dts                |  15 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  86 ++++----
 11 files changed, 742 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
