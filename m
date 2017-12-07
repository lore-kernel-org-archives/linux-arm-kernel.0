From: tony@atomide.com (Tony Lindgren)
Date: Thu,  7 Dec 2017 13:19:59 -0800
Subject: [GIT PULL] two dts compiler warning fixes for v4.15-rc cycle
Message-ID: <pull-1512681573-431149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.15/fixes-dt-warnings

for you to fetch changes up to c22fe696157dc94a25cc5396b43b29b6d6f4a189:

  ARM: dts: Fix dm814x missing phy-cells property (2017-12-05 08:29:04 -0800)

----------------------------------------------------------------
Two fixes for dts compiler warnings

These recently started showing up with better dtc checks being
introduced.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: dts: Fix elm interrupt compiler warning
      ARM: dts: Fix dm814x missing phy-cells property

 arch/arm/boot/dts/dm814x.dtsi | 1 +
 arch/arm/boot/dts/omap4.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
