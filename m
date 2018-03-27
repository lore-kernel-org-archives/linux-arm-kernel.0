From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 27 Mar 2018 16:05:23 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.17 (#2)
Message-ID: <87po3ptxzw.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.17.

Gregory

The following changes since commit a83aeb3836b1cd65770b20eafefbef7467972fa2:

  ARM: dts: armada388-clearfog: increase speed of i2c0 to 400kHz (2018-03-05 17:33:42 +0100)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.17-2

for you to fetch changes up to 29e36c1f63d16c6fe895fa4e33b01e45a11f96de:

  ARM: dts: armada388-clearfog: add SFP module support (2018-03-27 15:07:46 +0200)

----------------------------------------------------------------
mvebu dt for 4.17 (part 2)

 - add SFP module support on the clearfog (Armada 388 based board)

 - disable internal RTC node for Linksys boards (Armada 38x based
   boards)

----------------------------------------------------------------
Hauke Mehrtens (1):
      ARM: dts: armada-385-linksys: Disable internal RTC

Russell King (1):
      ARM: dts: armada388-clearfog: add SFP module support

 arch/arm/boot/dts/armada-385-linksys.dtsi  |  5 ++++
 arch/arm/boot/dts/armada-388-clearfog.dtsi | 45 ++++++++----------------------
 2 files changed, 17 insertions(+), 33 deletions(-)
