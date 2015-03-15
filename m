From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 16 Mar 2015 08:03:16 +0900
Subject: [GIT PULL v2] Second Round of Renesas ARM Based SoC Cleanup for v4.1
Message-ID: <cover.1426456752.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC cleanup for v4.1.


As requested by Arnd v2 of this pull request is based on v4.0-rc1.  The
previous version of this pull request was based on "Renesas ARM Based SoC
Cleanup for v4.1", tagged as renesas-soc-cleanup2-for-v4.1.  There are no
other changes between v1 and v2 of this pull request.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-cleanup2-for-v4.1

for you to fetch changes up to 6e5e9c6835e05ccc2be67486bc998b6f62663621:

  ARM: shmobile: r8a7740: Remove restart callback (2015-03-12 08:43:35 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Cleanup for v4.1

* Remove restart callback from r8a7740 SoC
* Remove unnecessary check on always set CONFIG_COMMON_CLK from
  shared R-Car Gen2 SoC code
* Remove stray closing parenthesis in SCIF debug description
  for R-Car Gen2 SoC

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: Remove stray closing parenthesis in debug description
      ARM: shmobile: R-Car Gen2: CONFIG_COMMON_CLK is always set
      ARM: shmobile: r8a7740: Remove restart callback

 arch/arm/Kconfig.debug                   | 2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c   | 8 --------
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 4 ----
 3 files changed, 1 insertion(+), 13 deletions(-)
