From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Mar 2018 18:10:46 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.17 (#1)
Message-ID: <87muzh2mzt.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.17.

Gregory

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.17-1

for you to fetch changes up to a83aeb3836b1cd65770b20eafefbef7467972fa2:

  ARM: dts: armada388-clearfog: increase speed of i2c0 to 400kHz (2018-03-05 17:33:42 +0100)

----------------------------------------------------------------
mvebu dt for 4.17 (part 1)

Most of them are small fixes or cleanup.

Only the change on the clearfog will have a noticeable effect allowing
to use the i2c at an higher frequency.

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: dts: armada: netgear-rn*: fix rtc node name

Geert Uytterhoeven (1):
      ARM: dts: kirkwood: Fix "debounce-interval" property misspelling

Rob Herring (1):
      arm: dts: kirkwood: fix error in #sound-dai-cells size

Russell King (1):
      ARM: dts: armada388-clearfog: increase speed of i2c0 to 400kHz

 arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 2 +-
 arch/arm/boot/dts/armada-388-clearfog.dtsi       | 7 ++-----
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 2 +-
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts | 2 +-
 arch/arm/boot/dts/kirkwood.dtsi                  | 2 +-
 6 files changed, 7 insertions(+), 10 deletions(-)
