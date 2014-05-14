From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 14 May 2014 16:26:55 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Boards Updates for
 v3.16
Message-ID: <cover.1400052350.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of
Renesas ARM based SoC boards updates for v3.16.

This pull request is based on the previous round of
such requests, tagged as renesas-boards-for-v3.16,
which you have previously pulled.


The following changes since commit a09b2f0ba170dc89a67d6c4c4f027b37a085dad9:

  ARM: shmobile: lager legacy: Enable Quad SPI transfers for the SPI FLASH (2014-04-15 08:13:22 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards2-for-v3.16

for you to fetch changes up to fd105ecf17fe459d979f336a7389d87172a1cf6d:

  ARM: shmobile: Minor cleanup of the Armadillo legacy board code (2014-05-11 20:59:57 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Boards Updates for v3.16

r8a7740 (R-Mobile A1) based Armadillo800 EVA board
* Minor cleanup of the Armadillo legacy board code

----------------------------------------------------------------
Magnus Damm (1):
      ARM: shmobile: Minor cleanup of the Armadillo legacy board code

 arch/arm/mach-shmobile/board-armadillo800eva.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)
