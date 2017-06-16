From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:31:16 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.13
Message-ID: <cover.1497619609.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.13.


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.13

for you to fetch changes up to fd8cf827d8a635df3dad46773ad828ce4c93d95b:

  ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ALWAYS_ON (2017-06-14 10:58:48 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.13

* Use GENPD_FLAG_ALWAYS_ON in pm-rmobile

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ALWAYS_ON

 arch/arm/mach-shmobile/pm-rmobile.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)
