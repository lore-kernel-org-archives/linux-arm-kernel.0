From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 May 2014 11:59:11 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.16 (incr. #2)
Message-ID: <20140522155911.GU8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's the last round DT changes for v3.16.  Nothing controversial, been
in -next a while.  This is an incremental pull request from
tags/mvebu-dt-3.16 to tags/mvebu-dt-3.16-2 in mvebu/dt.

Please pull.

thx,

Jason.


The following changes since commit 191825c38eafeda033a73338f5a710fa6fd5b3d6:

  ARM: Kirkwood: t5325: Use simple card to instantiate audio (2014-05-05 01:18:45 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.16-2

for you to fetch changes up to 599a136e5f4a7c3ca324fb2749ca235cd90c9d51:

  ARM: dts: kirkwood: add kirkwood-km_fixedeth DTS file (2014-05-16 17:57:27 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.16 (incremental #2)

 - kirkwood
    - add OpenRD boards
    - make keymile boards bootable with latest kernels

 - mvebu
    - add ehci/xhci to Armada 375/38x boards

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: DT versions of OpenRD boards

Gregory CLEMENT (4):
      ARM: mvebu: add Device Tree description of xHCI controllers on Armada 38x
      ARM: mvebu: add Device Tree description of the EHCI controller on Armada 38x
      ARM: mvebu: add Device Tree description of the xHCI controller on Armada 375
      ARM: mvebu: add Device Tree description for the EHCI controllers on Armada 375

Valentin Longchamp (3):
      ARM: dts: kirkwood: resynch 98dx4122 dtsi
      ARM: dts: kirkwood: add kirkwood-km_common DTSI files
      ARM: dts: kirkwood: add kirkwood-km_fixedeth DTS file

 arch/arm/boot/dts/Makefile                     |  3 +
 arch/arm/boot/dts/armada-375-db.dts            |  8 +++
 arch/arm/boot/dts/armada-375.dtsi              | 24 +++++++
 arch/arm/boot/dts/armada-385-db.dts            | 12 ++++
 arch/arm/boot/dts/armada-385-rd.dts            |  4 ++
 arch/arm/boot/dts/armada-38x.dtsi              | 24 +++++++
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi       | 43 ++++++++++++
 arch/arm/boot/dts/kirkwood-km_common.dtsi      | 48 ++++++++++++++
 arch/arm/boot/dts/kirkwood-km_fixedeth.dts     | 23 +++++++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts     | 38 +----------
 arch/arm/boot/dts/kirkwood-openrd-base.dts     | 42 ++++++++++++
 arch/arm/boot/dts/kirkwood-openrd-client.dts   | 73 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-openrd-ultimate.dts | 58 +++++++++++++++++
 arch/arm/boot/dts/kirkwood-openrd.dtsi         | 90 ++++++++++++++++++++++++++
 14 files changed, 453 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-km_common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-km_fixedeth.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-openrd-base.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-openrd-client.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-openrd-ultimate.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-openrd.dtsi
