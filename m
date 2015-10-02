From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  2 Oct 2015 11:29:28 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.3
Message-ID: <cover.1443752733.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.3.

These changes are required to restore working sound for the r8a779[01] SoCs
in v4.3.

My understanding is that with the inclusion of
"drivers: sh: Disable PM runtime for multi-platform ARM with genpd"
in v4.3-rc3 sound stopped working for the SoCs in question.

These patches were previously posted as part of
"Renesas ARM Based SoC DT Updates for v4.4".
I have withdrawn that pull request.


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.3

for you to fetch changes up to 56e86dd4bbeb66a7ad67e20fa045c6f51b4da571:

  ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound (2015-09-29 09:44:13 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.3

* Add Add CPG/MSTP Clock Domain for sound on r8a779[01] SoCs.
  This allows sound to work once again.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain for sound
      ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound

 arch/arm/boot/dts/r8a7790.dtsi | 1 +
 arch/arm/boot/dts/r8a7791.dtsi | 1 +
 2 files changed, 2 insertions(+)
