From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Jan 2016 19:04:58 +0100
Subject: [GIT PULL] ARM: mvebu: fixes for v4.5 (#1)
Message-ID: <871t908do5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for mvebu fixes for v4.5.

Gregory

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.5-1

for you to fetch changes up to ff61ee84e7aa5842d9e33c0b442f0b43a6a44eaf:

  ARM: dts: orion5x: gpio pin fixes for linkstation lswtgl (2016-01-25 16:22:59 +0100)

----------------------------------------------------------------
mvebu fixes for 4.5 (part 1)

- Fix dts on buffalo linksations machines (gpios and leds)
- Fix dts partition node according to new binding introduced in v4.5

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: mvebu: kirkwood: Add compatible property to "partitions" node
      ARM: mvebu: ix4-300d: Add compatible property to "partitions" node

Roger Shimizu (5):
      ARM: dts: kirkwood: gpio pin fixes for linkstation ls-wxl/wsxl
      ARM: dts: kirkwood: gpio pin fixes for linkstation ls-wvl/vl
      ARM: dts: kirkwood: gpio-leds fixes for linkstation ls-wxl/wsxl
      ARM: dts: kirkwood: gpio-leds fixes for linkstation ls-wvl/vl
      ARM: dts: orion5x: gpio pin fixes for linkstation lswtgl

 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  |  1 +
 arch/arm/boot/dts/kirkwood-lswvl.dts             | 25 ++++++++++---------
 arch/arm/boot/dts/kirkwood-lswxl.dts             | 31 ++++++++++++------------
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts |  1 +
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts |  8 +++---
 5 files changed, 35 insertions(+), 31 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
XF
