From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Feb 2016 16:22:47 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.6
Message-ID: <cover.1454409855.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.6.


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.6

for you to fetch changes up to 20cc7dd4d03d912d28a642701f08c7dba8622436:

  ARM: multi_v7_defconfig: Enable XHCI_RCAR (2016-01-27 18:23:03 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.6

* Enable XHCI_RCAR
* Do not enable CONFIG_CPU_BPREDICT_DISABLE

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Do not enable CONFIG_CPU_BPREDICT_DISABLE

Simon Horman (2):
      ARM: shmobile: enable XHCI_RCAR in defconfig
      ARM: multi_v7_defconfig: Enable XHCI_RCAR

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/shmobile_defconfig | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
