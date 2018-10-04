From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 04 Oct 2018 18:03:15 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.20 (#2)
Message-ID: <87va6hlmws.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.20. As I've
just sent the PR for dt64, I am also sending this small PR with a
patch I received last week.

Gregory

The following changes since commit e807f0298144c06740022a2f900d86b7f115595e:

  ARM: dts: clearfog: fix sdhci supply property name (2018-09-21 16:06:08 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.20-2

for you to fetch changes up to 5e72f5dc7e9d2ccc53e63cf1e4285d3f0534b685:

  ARM: dts: mvebu: armada-385-db-88f6820-amc: auto-detect nand ECC properites (2018-10-04 17:37:23 +0200)

----------------------------------------------------------------
mvebu dt for 4.20 (part 2)

Auto-detect nand ECC on the armada-385 based board db-88f6820-amc
instead of hard coded them in the device tree.

----------------------------------------------------------------
Chris Packham (1):
      ARM: dts: mvebu: armada-385-db-88f6820-amc: auto-detect nand ECC properites

 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts | 2 --
 1 file changed, 2 deletions(-)
