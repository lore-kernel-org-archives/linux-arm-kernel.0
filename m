From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  1 Jun 2015 15:53:23 +0800
Subject: [GIT PULL 1/4] ARM: imx: cleanup for 4.2
Message-ID: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-4.2

for you to fetch changes up to cb2e1a234c163d429712c0fa8eef8ab01499b738:

  ARM: imx: gpc: Remove .owner field (2015-05-11 21:38:25 +0800)

----------------------------------------------------------------
The i.MX cleanup for 4.2:
 - Remove eukrea_mbimxsd35 non-DT board files
 - Remove .owner field from gpc platform driver

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: imx: Remove eukrea_mbimxsd35 non-dt support
      ARM: imx: gpc: Remove .owner field

 arch/arm/mach-imx/Kconfig                      |  34 ---
 arch/arm/mach-imx/Makefile                     |   2 -
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c | 318 -------------------------
 arch/arm/mach-imx/gpc.c                        |   1 -
 arch/arm/mach-imx/mach-cpuimx35.c              | 206 ----------------
 5 files changed, 561 deletions(-)
 delete mode 100644 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
 delete mode 100644 arch/arm/mach-imx/mach-cpuimx35.c
