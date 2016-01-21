From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Jan 2016 11:41:12 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.5
Message-ID: <cover.1453343917.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.5.

This corrects the extal1 frequency on the armadillo800eva board.
This problem seems to have been around for a while and I would
like it considered for stable.


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.5

for you to fetch changes up to c61f30a255550bbfc6b83c1ca720661489cac4c0:

  ARM: dts: armadillo800eva Correct extal1 frequency to 24 MHz (2016-01-18 11:17:49 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.5

Correct extal1 frequency of armadillo800eva board

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: dts: armadillo800eva Correct extal1 frequency to 24 MHz

 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
