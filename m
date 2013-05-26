From: horms+renesas@verge.net.au (Simon Horman)
Date: Sun, 26 May 2013 22:05:51 +0900
Subject: [PATCH 0/6] Renesas ARM based r8a73a0 SoC updates for v3.11
Message-ID: <1369573557-11071-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-r8a73a4-for-v3.11

for you to fetch changes up to d7f17c1c0ddbd61ad24ae93ad9ec21fc223659ba:

  ARM: shmobile: Remove unused r8a73a4 GIC CPU interface DT bits (2013-05-26 20:17:43 +0900)

----------------------------------------------------------------
Renesas ARM based r8a73a0 SoC updates for v3.11

Clean-up from Maxime Ripard to remove unnecessary init_irq declaration in
machine description.

Clean-up from Magnus Damm to remove unused GIC CPU interface portions
of r8a73a4.dtsi

Increased clock coverage from Kuninori Morimoto.

----------------------------------------------------------------
Kuninori Morimoto (4):
      ARM: shmobile: r8a73a4: add main clock
      ARM: shmobile: r8a73a4: add pll clocks
      ARM: shmobile: r8a73a4: add div4 clocks
      ARM: shmobile: r8a73a4: add div6 clocks

Magnus Damm (1):
      ARM: shmobile: Remove unused r8a73a4 GIC CPU interface DT bits

Maxime Ripard (1):
      ARM: shmobile: r8a73a4: Remove init_irq declaration in machine description

 arch/arm/boot/dts/r8a73a4.dtsi         |    6 -
 arch/arm/mach-shmobile/clock-r8a73a4.c |  375 ++++++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/setup-r8a73a4.c |    2 -
 3 files changed, 359 insertions(+), 24 deletions(-)
