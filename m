From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 08 Apr 2017 00:08:54 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.12 (#2)
Message-ID: <87shlj50qx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.12.

Gregory

The following changes since commit cd2f0d0d403b7eb779fba04ea9664faa3b625cde:

  ARM: dts: mvebu: linksys: enable buffer manager support (2017-03-23 17:29:42 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.12-2

for you to fetch changes up to 34240c26d1d7b4365d4d0a8d231b244eb396c8dc:

  ARM: dts: armada-385-linksys: disk-activity trigger for all (2017-04-05 17:25:17 +0200)

----------------------------------------------------------------
mvebu dt for 4.12 (part 2)

Use disk-activity trigger for armada-385-linksys
Keep dts alphabetically ordered for clearfog (Armada 388)

----------------------------------------------------------------
Ralph Sennhauser (1):
      ARM: dts: armada-385-linksys: disk-activity trigger for all

Russell King (1):
      ARM: dts: clearfog: keep dts alphabetically ordered

 arch/arm/boot/dts/armada-385-linksys-caiman.dts |  1 -
 arch/arm/boot/dts/armada-385-linksys-cobra.dts  |  1 -
 arch/arm/boot/dts/armada-385-linksys.dtsi       |  1 +
 arch/arm/boot/dts/armada-388-clearfog.dts       | 38 ++++++++++++-------------
 4 files changed, 20 insertions(+), 21 deletions(-)
