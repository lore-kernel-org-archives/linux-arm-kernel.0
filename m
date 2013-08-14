From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Aug 2013 10:14:18 -0400
Subject: [GIT PULL] ARM: mvebu: fixes-non-critical for v3.12
Message-ID: <20130814141418.GC32395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Not too many fixes popped up this time around, so this is all that
accumulated.

thx,

Jason.

The following changes since commit 2746a7c272a3242f919fa2fd5a5f2d9f8a41173a:

  ARM: dove: fix missing __init section of dove_mpp_gpio_mode (2013-07-25 15:22:17 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/fixes-non-3.12-2

for you to fetch changes up to 35faad2a1563b3d4dc983a82ac41033fe053870c:

  ARM: dts: Fix memory node in skeleton64.dtsi (2013-08-07 16:33:50 +0000)

----------------------------------------------------------------
mvebu fixes-non-critical for v3.12 (round 2)

 - fix the memory node (2 by 2) in skeleton64.dtsi

----------------------------------------------------------------
Stepan Moskovchenko (1):
      ARM: dts: Fix memory node in skeleton64.dtsi

 arch/arm/boot/dts/skeleton64.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
