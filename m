From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jan 2017 18:07:32 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.11 (#2)
Message-ID: <87lgtwwhwr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.11.

Gregory

The following changes since commit 7b7db5ab33d2292d9b037cda0c41a795b094d940:

  ARM: dts: turris-omnia: add support for ethernet switch (2017-01-05 13:59:18 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.11-2

for you to fetch changes up to a3fe1d5dce142400945ecdc0d2e91b1645b6ebfa:

  ARM: dts: kirkwood-rd88f6281: Utilize new DSA binding (2017-01-19 23:47:11 +0100)

----------------------------------------------------------------
mvebu dt for 4.11 (part 2)

Switch device tree files to the new DSA binding

----------------------------------------------------------------
Florian Fainelli (8):
      ARM: dts: armada-370-rd: Utilize new DSA binding
      ARM: dts: armada-385-linksys: Utilize new DSA binding
      ARM: dts: armada-388-clearfog: Utilize new DSA binding
      ARM: dts: armada-xp-linksys-mamba: Utilize new DSA binding
      ARM: dts: kirkwood-dir665: Utilize new DSA binding
      ARM: dts: kirkwood-linksys-viper: Utilize new DSA binding
      ARM: dts: kirkwood-mv88f6281gtw-ge: Utilize new DSA binding
      ARM: dts: kirkwood-rd88f6281: Utilize new DSA binding

 arch/arm/boot/dts/armada-370-rd.dts            | 44 +++++++++++++++++
 arch/arm/boot/dts/armada-385-linksys.dtsi      | 52 ++++++++++++++++++++-
 arch/arm/boot/dts/armada-388-clearfog.dts      | 65 ++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts  | 53 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-dir665.dts          | 49 +++++++++++++++++++
 arch/arm/boot/dts/kirkwood-linksys-viper.dts   | 49 +++++++++++++++++++
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 49 +++++++++++++++++++
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts     |  9 ++--
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts    | 11 +++++
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi      | 44 +++++++++++++++++
 10 files changed, 419 insertions(+), 6 deletions(-)
