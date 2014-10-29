From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:58:17 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Clocks Updates for v3.19
Message-ID: <cover.1414558424.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC clocks updates for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocks-for-v3.19

for you to fetch changes up to 2b02b8020fad6ed505ff9cfb1b418c4b59f102a5:

  ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module (2014-10-24 10:30:50 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Clocks Updates for v3.19

* Add missing INTCA clock for irqpin module on r8a7740

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module

 arch/arm/mach-shmobile/clock-r8a7740.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
