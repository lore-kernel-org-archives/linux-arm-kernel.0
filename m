From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 14 Sep 2014 04:52:23 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.18
Message-ID: <20140914085223.GY21986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Wow, even the DT changes are small this time around...

Please pull.

thx,

Jason.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.18

for you to fetch changes up to 5b1e9e80c044442cc80eb6bb03b11165515eedb8:

  ARM: mvebu: add user LED support of Armada 370 RD (2014-09-13 21:13:42 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.18

 - Armada 375
    - Add RTC support

 - Armada 370
    - Add proper pinmuxing
    - Add SSCG
    - Add gpio-fan
    - Add LED support

 - change Intersil vendor prefix to isil
 - use improved Armada SPI compatible string

----------------------------------------------------------------
Ezequiel Garcia (6):
      ARM: mvebu: Add network pin mux configuration for the Armada 370 SoC
      ARM: mvebu: Add proper pin muxing on Globalscale Mirabox board
      ARM: mvebu: Add proper pin muxing on the Armada 370 DB board
      ARM: mvebu: Add proper pin muxing on Netgear ReadyNAS 102
      ARM: mvebu: Add proper pin muxing on Netgear ReadyNAS 104
      ARM: mvebu: Add proper pin muxing on Armada 370 RD board

Greg Ungerer (1):
      ARM: mvebu: use improved armada spi device tree compatible name

Gregory CLEMENT (2):
      ARM: mvebu: Add RTC support for Armada 375
      ARM: mvebu: add SSCG to Armada 370 Device Tree

Philipp Zabel (1):
      ARM: mvebu: Change vendor prefix for Intersil Corporation to isil

Thomas Petazzoni (2):
      ARM: mvebu: add gpio fan support to Armada 370 RD
      ARM: mvebu: add user LED support of Armada 370 RD

 arch/arm/boot/dts/armada-370-db.dts            |  6 +++++
 arch/arm/boot/dts/armada-370-mirabox.dts       |  6 +++++
 arch/arm/boot/dts/armada-370-netgear-rn102.dts |  6 ++++-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts |  8 +++++-
 arch/arm/boot/dts/armada-370-rd.dts            | 36 ++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi           |  4 +--
 arch/arm/boot/dts/armada-370.dtsi              | 23 ++++++++++++++++
 arch/arm/boot/dts/armada-375.dtsi              |  6 +++++
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts |  2 +-
 9 files changed, 92 insertions(+), 5 deletions(-)
