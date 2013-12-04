From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  4 Dec 2013 16:51:37 +0100
Subject: [PATCH v2 0/2] ARM: DT: Kirkwood: Use symbolic names
Message-ID: <1386172299-9105-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes use of the symbolic names in input.h and gpio.h
within the Kirkwood DT files.

Since v1:
  Drop ReadyNAS hunks
  Rebase on mvebu/dt and fix all the conflicts
  Remove the now redundant includes in the ReadyNAS .dts files.

Andrew Lunn (2):
  ARM: DT: Kirkwood: Use symbolic names from input.h
  ARM: DT: Kirkwood: Use symbolic names from gpio.h

 arch/arm/boot/dts/kirkwood-cloudbox.dts            | 10 +++----
 arch/arm/boot/dts/kirkwood-db.dtsi                 |  4 +--
 arch/arm/boot/dts/kirkwood-dns320.dts              | 10 +++----
 arch/arm/boot/dts/kirkwood-dns325.dts              | 10 +++----
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              | 18 ++++++------
 arch/arm/boot/dts/kirkwood-dockstar.dts            |  4 +--
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  6 ++--
 arch/arm/boot/dts/kirkwood-goflexnet.dts           | 22 +++++++--------
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  8 +++---
 arch/arm/boot/dts/kirkwood-ib62x0.dts              | 16 +++++------
 arch/arm/boot/dts/kirkwood-iconnect.dts            | 24 ++++++++--------
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      | 20 +++++++-------
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |  4 +--
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               | 28 +++++++++----------
 arch/arm/boot/dts/kirkwood-mplcec4.dts             | 14 +++++-----
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     | 14 +++++-----
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  2 --
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |  2 --
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  8 +++---
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |  2 +-
 arch/arm/boot/dts/kirkwood-ns2max.dts              | 10 +++----
 arch/arm/boot/dts/kirkwood-ns2mini.dts             | 10 +++----
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi      |  4 +--
 arch/arm/boot/dts/kirkwood-nsa310.dts              | 32 +++++++++++-----------
 arch/arm/boot/dts/kirkwood-nsa310a.dts             | 30 ++++++++++----------
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       | 10 +++----
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       | 10 +++----
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |  6 ++--
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |  4 +--
 arch/arm/boot/dts/kirkwood-topkick.dts             | 10 +++----
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |  8 +++---
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  8 +++---
 arch/arm/boot/dts/kirkwood.dtsi                    |  2 ++
 33 files changed, 184 insertions(+), 186 deletions(-)

-- 
1.8.5
