From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Sep 2014 13:14:19 +0900
Subject: [GIT PULL] Fifth Round of Renesas ARM Based SoC Soc Updates for v3.18
Message-ID: <cover.1411100007.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fifth round of Renesas ARM based SoC soc updates for v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-soc4-for-v3.18,
which I have already sent a pull-request for.


The following changes since commit 1370078db37de2aa5e906ae2b5dbbb6ba289adb4:

  ARM: shmobile: r8a7794: Remove unnecessary #ifdef CONFIG_USE_OF (2014-09-11 09:51:16 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc5-for-v3.18

for you to fetch changes up to 8237f9e5c38098aeb8570a77bacd0fe0ebc61dfa:

  ARM: shmobile: r8a7740 legacy: Fix copied bug in comment (2014-09-17 09:20:53 +0900)

----------------------------------------------------------------
Fifth Round of Renesas ARM Based SoC Soc Updates for v3.18

* r8a7740: Fix documentation error coppied from elsewhere
* r8a7794: Reserve memory for CMA in a manner consistent to
           other R-Car Gen2 SoCs

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: r8a7740 legacy: Fix copied bug in comment

Magnus Damm (1):
      ARM: shmobile: r8a7794: Reserve memory as other R-Car Gen2 SoCs

 arch/arm/mach-shmobile/pm-r8a7740.c    | 2 +-
 arch/arm/mach-shmobile/setup-r8a7794.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
