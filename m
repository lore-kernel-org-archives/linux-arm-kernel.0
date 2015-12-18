From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:28:59 +0900
Subject: [GIT PULL] Third Round of Renesas ARM64 Based SoC Defconfig Updates
 for v4.5
Message-ID: <cover.1450400996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM64 based SoC defconfig
updates for v4.5.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-defconfig2-for-v4.5,
which you have already pulled.


The following changes since commit 05a64b3b8b41bf3c3ca9b7f9f8a0e81ffadb20e3:

  arm64: defconfig: add Renesas sound and AK4613 support (2015-11-26 11:35:21 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig3-for-v4.5

for you to fetch changes up to d3643e1669e59c374e78e3af9d93def5ac1f81bc:

  arm64: defconfig: add CS2000 support (2015-12-18 10:06:57 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM64 Based SoC Defconfig Updates for v4.5

* Enable CS2000 and Renesas R-Car SATA driver

----------------------------------------------------------------
Kouei Abe (1):
      arm64: defconfig: Add Renesas R-Car SATA driver for R-Car Gen3 SoCs

Kuninori Morimoto (1):
      arm64: defconfig: add CS2000 support

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
