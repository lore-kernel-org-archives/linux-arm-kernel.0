From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Dec 2014 11:33:15 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Fixes for v3.19
Message-ID: <cover.1418265122.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig fixes for v3.19.

This pull request is based on the previous round of
such requests, tagged as defconfig-for-v3.19,
which I have already sent a pull-request for.


The following changes since commit ccde0fbd4fe88151c8d3a93a3e3a939a0a1753b2:

  ARM: shmobile: multiplatform: add AK4642 support on defconfig (2014-11-05 14:47:56 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-fixes-for-v3.19

for you to fetch changes up to b6f6383b98092a1759d19893875bba90c8d9f446:

  Revert "ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig" (2014-12-10 11:33:24 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Fixes for v3.19

* Revert change enabling RCAR_AUDMAC_PP in shmobile_defconfig

  Unfortunately enabling RCAR_AUDMAC_PP support this patch breaks dmaengine
  support on R-Car Gen2 boards. This should be resolved by driver updates
  in v3.20. But v3.19 was too early for this defconfig change.

----------------------------------------------------------------
Simon Horman (1):
      Revert "ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig"

 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)
