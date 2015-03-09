From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 09 Mar 2015 20:42:57 +0100
Subject: [GIT PULL] ARM: mvebu: SoC changes for v4.1
Message-ID: <54FDF7C1.1000608@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for SoC for mvebu for v4.1

Gregory

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.1

for you to fetch changes up to 0d9ab18e337609b010800ac493c588b0a24c2dd2:

  Documentation: arm: update supported Marvell EBU processors (2015-03-04 15:35:43 +0100)

----------------------------------------------------------------
mvebu soc changes for v4.1 (part #1)

- Add support for a new SoC: Armada 39x

----------------------------------------------------------------
Thomas Petazzoni (4):
      devicetree: bindings: add DT binding for the Marvell Armada 39x SoC family
      devicetree: bindings: add new SMP enable method for Marvell Armada 39x
      ARM: mvebu: add core support for Armada 39x
      Documentation: arm: update supported Marvell EBU processors

 Documentation/arm/Marvell/README                     |  5 +++++
 Documentation/devicetree/bindings/arm/armada-39x.txt | 20 ++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt       |  1 +
 arch/arm/mach-mvebu/Kconfig                          | 14 ++++++++++++++
 arch/arm/mach-mvebu/board-v7.c                       | 14 ++++++++++++++
 arch/arm/mach-mvebu/platsmp-a9.c                     |  2 ++
 6 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-39x.txt
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
