From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:25:34 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v3.17
Message-ID: <cover.1403487196.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v3.17.


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-defconfig-for-v3.17

for you to fetch changes up to 468c570ed078f0326745bfe85868adb925659502:

  ARM: shmobile: Enable CPUFREQ configuration (2014-06-16 19:44:34 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v3.17

* Enable Marzen board and r8a7779 SoC, CPUFREQ and PM_RUNTIME in
  shmobile (multiplatform) defconfig
* Enable LED support in armadillo800eva defconfig

----------------------------------------------------------------
Gaku Inami (1):
      ARM: shmobile: Enable CPUFREQ configuration

Geert Uytterhoeven (1):
      ARM: shmobile: armadillo800eva defconfig: Enable REGULATOR_GPIO and LEDS_GPIO

Simon Horman (2):
      ARM: shmobile: marzen: Add to shmobile defconfig
      ARM: shmobile: Enable PM_RUNTIME in defconfig

 arch/arm/configs/armadillo800eva_defconfig |  4 ++++
 arch/arm/configs/shmobile_defconfig        | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)
