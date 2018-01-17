From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 17 Jan 2018 16:11:42 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.16 (#3)
Message-ID: <87bmhs7c5t.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the late pull request for dt64 for mvebu for v4.16, actually
it is a fix needed for what we have currently in linux-next.

Thanks,

Gregory

The following changes since commit 474c5885582c4a79c21bcf01ed98f98c935f1f4a:

  arm64: dts: marvell: add Ethernet aliases (2018-01-05 17:02:45 +0100)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.16-3

for you to fetch changes up to f9a0c27b5c3c93b824c2978fafc250ba969b1602:

  arm64: dts: marvell: armada-80x0: Fix pinctrl compatible string (2018-01-12 17:00:12 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.16 (part 3)

Fix for the CP110 dt de-duplication series

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm64: dts: marvell: armada-80x0: Fix pinctrl compatible string

 arch/arm64/boot/dts/marvell/armada-80x0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
