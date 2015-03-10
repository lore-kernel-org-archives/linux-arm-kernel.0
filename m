From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:42:09 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Cleanup for v4.1
Message-ID: <cover.1425947508.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC cleanup for v4.1.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-cleanup-for-v4.1,
which you have already pulled.


The following changes since commit fd9454ab51fa92f43ae5b7a71c42f2ee8417c2a2:

  ARM: shmobile: r8a7779: Remove redundant cpu_disable implementation (2015-02-24 07:12:16 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-cleanup2-for-v4.1

for you to fetch changes up to 82fbf29f26733dd38bd2ab17db04e0aa46ef3857:

  ARM: shmobile: r8a7740: Remove restart callback (2015-03-01 10:59:16 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Cleanup for v4.1

* Remove restart callback from r8a7740 SoC
* Remove unecessary check on always set CONFIG_COMMON_CLK from
  shared R-Car Gen2 SoC code
* Remove stray closing parenthesis in SCIF debug description
  for R-Car Gen2 SoCa

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: Remove stray closing parenthesis in debug description
      ARM: shmobile: R-Car Gen2: CONFIG_COMMON_CLK is always set
      ARM: shmobile: r8a7740: Remove restart callback

 arch/arm/Kconfig.debug                   | 2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c   | 8 --------
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 4 ----
 3 files changed, 1 insertion(+), 13 deletions(-)
