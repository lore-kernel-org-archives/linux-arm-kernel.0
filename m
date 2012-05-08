From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 May 2012 12:28:58 -0600
Subject: [GIT PULL] ARM: tegra: tegra30-audio branch
Message-ID: <4FA965EA.90607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch is based on my previous gpio-pinmux pull request.

This branch instantiates the Tegra ASoC driver on Tegra30, and provides
various required AUXDATA, clock setup, etc.

The following changes since commit aef7704c6cc36db9618603b22194def441d30432:
  Stephen Warren (1):
        pinctrl: tegra: error reporting cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
for-3.5/tegra30-audio

Peter De Schrijver (1):
      ARM: tegra: Initialize pll_p_out1

Stephen Warren (5):
      ARM: tegra: provide clock aliases for AHUB configlink
      ARM: tegra: set up audio clocks for tegra30 dt
      ARM: tegra: add AUXDATA required for audio
      ARM: dt: tegra30.dtsi: Add audio-related nodes
      ARM: dt: tegra cardhu: basic audio support

 arch/arm/boot/dts/tegra-cardhu.dts     |   63
++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi         |   41 +++++++++++++++++++++
 arch/arm/mach-tegra/board-dt-tegra30.c |   10 +++++
 arch/arm/mach-tegra/common.c           |   12 ++++++
 arch/arm/mach-tegra/tegra30_clocks.c   |    9 +++++
 5 files changed, 135 insertions(+), 0 deletions(-)
