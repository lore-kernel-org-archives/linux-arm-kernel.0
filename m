From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:58:37 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Kconfig Cleanups for v3.19
Message-ID: <cover.1414557793.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC kconfig cleanups for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-kconfig-cleanups-for-v3.19

for you to fetch changes up to 383d3f3e979bfbace3101dacb21387806b44e847:

  ARM: shmobile: Remove ARCH_HAS_OPP completely (2014-10-24 10:41:56 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Kconfig Cleanups for v3.19

* Remove reference to ARCH_HAS_OPP, it has been removed

----------------------------------------------------------------
Paul Bolle (1):
      ARM: shmobile: Remove ARCH_HAS_OPP completely

 arch/arm/mach-shmobile/Kconfig | 1 -
 1 file changed, 1 deletion(-)
