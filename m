From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Oct 2015 18:13:04 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.4
Message-ID: <87fv1krpf3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.4.

Gregory

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.4-1

for you to fetch changes up to 9b24a35cb59888194706825b9c5ac550b0880277:

  ARM: mvebu: modify Orion and Kirkwoord crypto compatible strings (2015-10-09 17:08:02 +0200)

----------------------------------------------------------------
mvebu dt for 4.4 (part 1)

Update dts to use the new crypto driver on mvebu SoCs

----------------------------------------------------------------
Arnaud Ebalard (1):
      ARM: mvebu: add crypto related nodes to armada 370 dtsi

Boris Brezillon (9):
      ARM: mvebu: add crypto related nodes to armada-xp.dtsi
      ARM: mvebu: define crypto SRAM ranges for all armada-xp boards
      ARM: mvebu: define crypto SRAM ranges for all armada-370 boards
      ARM: mvebu: add crypto related nodes to armada 375 dtsi
      ARM: mvebu: define crypto SRAM ranges in armada-375-db.dts
      ARM: mvebu: add crypto related nodes to armada 38x dtsi
      ARM: mvebu: define crypto SRAM ranges for all armada-38x boards
      ARM: mvebu: use new bindings for existing crypto devices
      ARM: mvebu: modify Orion and Kirkwoord crypto compatible strings

Thomas Petazzoni (1):
      ARM: mvebu: add CPU config registers in the Armada 370/XP Device Tree

 arch/arm/boot/dts/armada-370-db.dts              |  3 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts   |  3 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         |  7 ++++-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   |  3 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   |  3 +-
 arch/arm/boot/dts/armada-370-rd.dts              |  3 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts |  3 +-
 arch/arm/boot/dts/armada-370.dtsi                | 37 ++++++++++++++++++++++++
 arch/arm/boot/dts/armada-375-db.dts              |  4 ++-
 arch/arm/boot/dts/armada-375.dtsi                | 33 +++++++++++++++++++++
 arch/arm/boot/dts/armada-385-db-ap.dts           |  4 ++-
 arch/arm/boot/dts/armada-385-linksys.dtsi        |  4 ++-
 arch/arm/boot/dts/armada-388-db.dts              |  4 ++-
 arch/arm/boot/dts/armada-388-gp.dts              |  4 ++-
 arch/arm/boot/dts/armada-388-rd.dts              |  4 ++-
 arch/arm/boot/dts/armada-38x.dtsi                | 33 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        |  4 ++-
 arch/arm/boot/dts/armada-xp-db.dts               |  4 ++-
 arch/arm/boot/dts/armada-xp-gp.dts               |  4 ++-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  |  4 ++-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts    |  4 ++-
 arch/arm/boot/dts/armada-xp-matrix.dts           |  4 ++-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   |  4 ++-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  4 ++-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   |  4 ++-
 arch/arm/boot/dts/armada-xp.dtsi                 | 35 ++++++++++++++++++++++
 arch/arm/boot/dts/dove.dtsi                      | 17 ++++++++---
 arch/arm/boot/dts/kirkwood.dtsi                  | 29 ++++++++++++-------
 arch/arm/boot/dts/orion5x.dtsi                   | 22 +++++++++-----
 29 files changed, 248 insertions(+), 43 deletions(-)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
