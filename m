From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:25:25 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cpufreq Updates for v3.17
Message-ID: <cover.1403487159.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this Renesas ARM based SoC cpufreq update for v3.17.


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-cpufreq-for-v3.17

for you to fetch changes up to 06e32c91dbce3c24ccbe84e3af2a35199662bca0:

  ARM: shmobile: add cpufreq-cpu0 driver for common SH-Mobile (2014-06-16 19:50:54 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Cpufreq Updates for v3.17

* Add cpufreq-cpu0 driver

----------------------------------------------------------------
Gaku Inami (1):
      ARM: shmobile: add cpufreq-cpu0 driver for common SH-Mobile

 arch/arm/mach-shmobile/Makefile              |  1 +
 arch/arm/mach-shmobile/cpufreq.c             | 31 ++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |  7 +++++++
 3 files changed, 39 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/cpufreq.c
