From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:21 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v3.20
Message-ID: <cover.1419808942.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v3.20.


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.20

for you to fetch changes up to db54d850b686c2ca81c10dd3582e98ee089a0e3a:

  ARM: shmobile: Enable DA9063 watchdog in multiplatform defconfig (2014-12-21 16:53:36 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v3.20

* Enable DA9063, MICREL_PHY and MTD_BLOCK watchdog in multiplatform defconfig
* Update AK8975 config option in kzm9g defconfig

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: kzm9g_defconfig: Update AK8975 config option
      ARM: shmobile: Enable MICREL_PHY in shmobile_defconfig
      ARM: shmobile: Enable DA9063 watchdog in multiplatform defconfig

Kuninori Morimoto (2):
      ARM: shmobile: defconfig: cleanup by savedefconfig
      ARM: shmobile: defconfig: add MTD_BLOCK

 arch/arm/configs/kzm9g_defconfig    |  2 +-
 arch/arm/configs/shmobile_defconfig | 30 ++++++++++++++----------------
 2 files changed, 15 insertions(+), 17 deletions(-)
