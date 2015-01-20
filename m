From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 20 Jan 2015 10:27:08 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Updates for v3.20
Message-ID: <cover.1421715134.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC updates for v3.20.

This pull request is based on the previous round of
such requests, tagged as renesas-soc2-for-v3.20,
which I have already sent a pull-request for.


The following changes since commit 2173fc7cb681c38b9e5bc526211045caecf96e44:

  ARM: shmobile: R-Mobile: Add DT support for PM domains (2015-01-15 08:38:14 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc3-for-v3.20

for you to fetch changes up to 1632ff162f305f38667632c465e4bfaab8ef87a2:

  ARM: shmobile: R-Mobile: Special-case PM domains with memory-controllers (2015-01-16 11:02:42 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Updates for v3.20

* Special-case PM domains with memory-controllers

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: R-Mobile: Consolidate rmobile_pd_suspend_*()
      ARM: shmobile: R-Mobile: Generalize adding/looking up special PM domains
      ARM: shmobile: R-Mobile: Special-case PM domains with memory-controllers

 arch/arm/mach-shmobile/pm-rmobile.c | 155 ++++++++++++++++++++++--------------
 1 file changed, 97 insertions(+), 58 deletions(-)
