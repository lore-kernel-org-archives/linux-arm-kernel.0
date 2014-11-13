From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:19:32 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Boards Updates for v3.19
Message-ID: <cover.1415756816.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC boards updates for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.19

for you to fetch changes up to 534547c036afad3f23d49d8352896f5d05709685:

  ARM: shmobile: kzm9g-reference: Add restart callback (2014-11-10 10:16:35 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Boards Updates for v3.19

* Add restart callback to kzm9g

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: kzm9g-reference: Add restart callback

 arch/arm/mach-shmobile/board-kzm9g-reference.c | 8 ++++++++
 1 file changed, 8 insertions(+)
