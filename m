From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Jun 2014 09:01:29 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
Message-ID: <20140627130129.GH23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

It's a pretty slow cycle this time around, so here's what I have so far.
Nothing controversial, just putting the last nail in the coffin for
mach-kirkwood/ . :-)

Please pull.

thx,

Jason.

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.17

for you to fetch changes up to d854fa8a1500bec982ed9cb26b82d96bd5ae8dab:

  ARM: kirkwood: fix net5big regulator gpio assignments (2014-06-21 19:21:13 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.17

 - kirkwood
    - add boards net2big and net5big

 - dove
    - add vendor prefix for SolidRun
    - split CuBox into it's variants

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: Add DT descriptions for net2big and net5big.

Jason Cooper (1):
      ARM: kirkwood: fix net5big regulator gpio assignments

Sebastian Hesselbarth (2):
      dt-binding: add vendor prefix for SolidRun
      ARM: dts: mvebu: split SolidRun CuBox into variants

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/dove-cubox-es.dts                |  12 ++
 arch/arm/boot/dts/dove-cubox.dts                   |   3 -
 arch/arm/boot/dts/kirkwood-net2big.dts             |  30 ++++
 arch/arm/boot/dts/kirkwood-net5big.dts             |  83 ++++++++++
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            | 180 +++++++++++++++++++++
 7 files changed, 309 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/dove-cubox-es.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net2big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-net5big.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-netxbig.dtsi
