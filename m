From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 May 2015 14:46:51 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.1
Message-ID: <cover.1430977471.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.1.

This addresses a short-coming which was introduced when
the adv7511 was enabled on the koelsch board.


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.1

for you to fetch changes up to 12392f5896c9affc03c1ddd95a83c32238862a58:

  ARM: shmobile: koelsch: Fix adv7511 IRQ sensing (2015-05-01 09:13:03 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.1

* Fix adv7511 IRQ sensing on koelsch board

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: koelsch: Fix adv7511 IRQ sensing

 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
