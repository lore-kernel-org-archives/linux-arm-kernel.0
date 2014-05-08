From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 May 2014 10:39:07 -0400
Subject: [GIT PULL] ARM: mvebu: DT fixes for v3.15 (incr #2)
Message-ID: <20140508143907.GA12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

guys,

Looks like this is the last fix to trickle in for this cycle.  I've
waited over a week and seen nothing else.

As usual, this is an incremental pull request from
tags/mvebu-dt-fixes-3.15 up to tags/mvebu-dt-fixes-3.15-2 in the
mvebu/dt-fixes branch.

This patch has been is -next for several days.

Please pull.

thx,

Jason.


The following changes since commit e247686085f71e9c25e3488ce83d5d0f77023438:

  ARM: Kirkwood: T5325: Fix double probe of Codec (2014-04-25 21:23:42 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-fixes-3.15-2

for you to fetch changes up to 788296b2d19d16ec33aba0a5ad1544d50bb58601:

  ARM: dts: kirkwood: fix mislocated pcie-controller nodes (2014-05-05 00:43:15 +0000)

----------------------------------------------------------------
mvebu DT fixes for v3.15 (incremental #2)

 - kirkwood: fix mis-located pcie controller nodes

----------------------------------------------------------------
Sebastian Hesselbarth (1):
      ARM: dts: kirkwood: fix mislocated pcie-controller nodes

 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 18 ++++++++++--------
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi  | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 16 deletions(-)
