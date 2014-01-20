From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 Jan 2014 15:01:10 -0500
Subject: [GIT PULL] ARM: mvebu: DT boards for v3.14 (incr #6)
Message-ID: <20140120200110.GW29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I had a few boards that came in late in the cycle.  I was holding on to
them for the next round, but after Olof's comment this morning:

  Re: [PATCH 0/2] DT updates for Hummingboard and new Cubox-i
  http://www.spinics.net/lists/arm-kernel/msg301777.html

I figured I'd send them off.  As usual, they've been in -next for a
while.  Also, this is an incremental request from tags/mvebu-dt-3.14-5
to tags/mvebu-dt-3.14-6 on the mvebu/dt branch.

If this is going to be ok for the forseeable future, I'll do a separate
branch for new boards next time around.

thx,

Jason.


The following changes since commit 2cc64b5655da65bbb6a760a722b5ab1f53f92cf7:

  ARM: Kirkwood: DT board setup for LaPlug (2013-12-25 02:03:52 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.14-6

for you to fetch changes up to 57d647cf8d32f52a505bc51c34f8074f06f00b03:

  ARM: Kirkwood: Add DT description of QNAP 419 (2014-01-14 00:46:44 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.14 (incremental #6)

 - kirkwood
    - add board Excito Bubba B3
    - add board QNAP 419

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: Kirkwood: Add support for Excito Bubba B3
      ARM: Kirkwood: Add DT description of QNAP 419

 arch/arm/boot/dts/Makefile                |   7 +-
 arch/arm/boot/dts/kirkwood-b3.dts         | 204 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-ts419-6281.dts |  20 +++
 arch/arm/boot/dts/kirkwood-ts419-6282.dts |  32 +++++
 arch/arm/boot/dts/kirkwood-ts419.dtsi     |  75 +++++++++++
 5 files changed, 336 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-b3.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts419.dtsi
