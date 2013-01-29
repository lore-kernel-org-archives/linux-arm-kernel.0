From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 29 Jan 2013 18:32:59 +0000
Subject: [GIT PULL] vexpress: fixes for v3.9
Message-ID: <1359484379.8090.25.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git tags/vexpress/fixes-for-3.9

for you to fetch changes up to aab7da708649388afc041b173e7d2cf0c4b27e50:

  ARM: vexpress: Fix wdt interrupt in ca15{-tc1,_a7} dts (2013-01-29 18:20:28 +0000)

----------------------------------------------------------------
Versatile Express related fixes for 3.9
* Correct interrupt definitions for WDT node in
  V2P-CA15 and V2P-CA15_A7 Device Trees

----------------------------------------------------------------
Mark Rutland (1):
      ARM: vexpress: Fix wdt interrupt in ca15{-tc1,_a7} dts

 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |    2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
