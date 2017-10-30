From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Oct 2017 15:27:09 +0100
Subject: [GIT PULL] ARM: mvebu: fixes for v4.14 (#3)
Message-ID: <87efpk3e4i.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for fixes for mvebu for v4.14.

Gregory

The following changes since commit 2bbbd96357ce76cc45ec722c00f654aa7b189112:

  bus: mbus: fix window size calculation for 4GB windows (2017-10-12 15:01:30 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.14-3

for you to fetch changes up to cda80a82ac3e89309706c027ada6ab232be1d640:

  ARM: dts: mvebu: pl310-cache disable double-linefill (2017-10-26 17:41:26 +0200)

----------------------------------------------------------------
mvebu fixes for 4.14 (part 3)

Fixing an old stability issue on Cortex A9 based mvebu SoC

----------------------------------------------------------------
Yan Markman (1):
      ARM: dts: mvebu: pl310-cache disable double-linefill

 arch/arm/boot/dts/armada-375.dtsi | 4 ++--
 arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
 arch/arm/boot/dts/armada-39x.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
