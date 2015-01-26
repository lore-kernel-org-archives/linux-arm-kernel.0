From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 26 Jan 2015 15:15:44 +0100
Subject: [PATCH v2 00/27] ARM: mvebu: armada-*: Relicense the device tree
 under GPLv2+/X11
Message-ID: <1422281771-31443-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Andrew,

Eventually I managed to collect the acked(by for all the
patches. Besides adding the acked(by on the patches, the other change
was a rebased onto mvebu/dt. Indeed, since 3.19-rc1 some files were
renamed from armada-385 to armada-388.

I know that it is now quite late in the cycle however I would like to
see this series merged for 3.20. It should not introduce any
regression as all the change are made inside the comment blocks, so
for the stability it should be safe to take them.

My main motivation for having this series merged in 3.20 is to avoid
asking each author of the dts(i) patches if he agrees with the dual
license during the next cycle.

Olof, would you accept taking this series through mvebu?

Andrew, if Olof agrees, would you do a pull request with this series?

As written above, this series is based onto mvebu/dt and especially on
git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.20-2. If
needed I can provide a git branch to ease the merge.

Thanks!

Gregory

Gregory CLEMENT (27):
  ARM: mvebu: armada-370-db: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-370: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-370-mirabox: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-370-netgear-rn102: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-370-netgear-rn104: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-370-rd: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-370-synology-ds213j: Relicense the device tree
    under GPLv2+/X11
  ARM: mvebu: armada-370-xp: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-375-db: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-375: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-380: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-388-db: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-385: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-388-rd: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-38x: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-xp-axpwifiap: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-xp-db: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-xp: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-xp-gp: Relicense the device tree under GPLv2+/X11
  ARM: mvebu: armada-xp-lenovo-ix4-300d: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-xp-matrix: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-xp-mv78230: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-xp-mv78260: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-xp-mv78460: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-xp-netgear-rn2120: Relicense the device tree under
    GPLv2+/X11
  ARM: mvebu: armada-xp-openblocks-ax3-4: Relicense the device tree
    under GPLv2+/X11
  ARM: mvebu: armada-xp-synology-ds414: Relicense the device tree under
    GPLv2+/X11

 arch/arm/boot/dts/armada-370-db.dts              | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-370-mirabox.dts         | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 41 +++++++++++++++++++++---
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 41 +++++++++++++++++++++---
 arch/arm/boot/dts/armada-370-rd.dts              | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 41 +++++++++++++++++++++---
 arch/arm/boot/dts/armada-370-xp.dtsi             | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-370.dtsi                | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-375-db.dts              | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-375.dtsi                | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-380.dtsi                | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-385.dtsi                | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-388-db.dts              | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-388-rd.dts              | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-38x.dtsi                | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-xp-db.dts               | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-xp-gp.dts               | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  | 41 +++++++++++++++++++++---
 arch/arm/boot/dts/armada-xp-matrix.dts           | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi         | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 41 +++++++++++++++++++++---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 40 +++++++++++++++++++++--
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 41 +++++++++++++++++++++---
 arch/arm/boot/dts/armada-xp.dtsi                 | 40 +++++++++++++++++++++--
 27 files changed, 999 insertions(+), 87 deletions(-)

-- 
2.1.0
