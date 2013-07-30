From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 18:00:41 +0900
Subject: [PATCH 0/5] Renesas ARM-based SoC board updates for v3.12
Message-ID: <cover.1375174556.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider these Renesas ARM-based SoC board updates for v3.12.
This pull-request is based on renesas-soc-for-v3.12 which I have previously
sent a pull-request for.

The following changes since commit 81b9d5351fa96caad4accc6711bc1b9342927d4a:

  ARM: shmobile: Setup r8a7790 arch timer based on MD pins (2013-07-17 14:26:56 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to f79d68da510bf1b95beff4d556b78d06801f11dc:

  ARM: shmobile: ape6evm: add SDHI interfaces (2013-07-25 14:46:38 +0900)

----------------------------------------------------------------
Renesas ARM-based SoC board updates for v3.12

* ape6evm: Add SDHI and MMCIF support
* lager: Add MMCIF support
* armadillo800eva: Add DMA support for MMCIF

----------------------------------------------------------------
Guennadi Liakhovetski (4):
      ARM: shmobile: armadillo800eva: add DMA support to MMCIF
      ARM: shmobile: lager: add MMCIF support
      ARM: shmobile: ape6evm: add MMCIF support
      ARM: shmobile: ape6evm: add SDHI interfaces

Kuninori Morimoto (1):
      ARM: shmobile: select the fixed regulator driver on BockW

 arch/arm/mach-shmobile/Kconfig                 |  1 +
 arch/arm/mach-shmobile/board-ape6evm.c         | 79 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c |  2 +
 arch/arm/mach-shmobile/board-lager.c           | 31 ++++++++++
 4 files changed, 113 insertions(+)
