From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 10:00:19 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.8
Message-ID: <cover.1465347025.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.8.


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.8

for you to fetch changes up to c94bc815f3c757df402d6f6a3e8d855b9168e6af:

  ARM: shmobile: rcar-gen2: Use ICRAM1 for jump stub on all SoCs (2016-05-30 09:39:43 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.8

* Use ICRAM1 for jump stub on R-Car Gen 2 SoCs
* Postpone call to pm_genpd_init

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: pm-rmobile: Postpone call to pm_genpd_init()
      ARM: shmobile: rcar-gen2: Use ICRAM1 for jump stub on all SoCs

 arch/arm/mach-shmobile/pm-rcar-gen2.c | 13 ++++---------
 arch/arm/mach-shmobile/pm-rmobile.c   |  2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)
