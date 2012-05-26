From: olof@lixom.net (Olof Johansson)
Date: Sat, 26 May 2012 00:22:31 -0700
Subject: [GIT PULL 1/8] arm-soc: defconfig updates
In-Reply-To: <1338016958-7887-1-git-send-email-olof@lixom.net>
References: <1338016958-7887-1-git-send-email-olof@lixom.net>
Message-ID: <1338016958-7887-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the first time, we have one branch that collects just updates to
defconfig files, mostly for adapting to changes in other subsystems.

----------------------------------------------------------------

The following changes since commit 786f02b719f2285e2c0350b6a04dab4a1a0871a1:

  Merge tag 'x86-mce-merge' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/defconfig

for you to fetch changes up to 4a230408e83698a3d7ff0a9988a58675c2c92cb9:

  ARM: PRIMA2: add prima2_defconfig for CSR SiRFprimaII

----------------------------------------------------------------

Arnd Bergmann (2):
      Merge tag 'imx-defconfig' of git://git.pengutronix.de/git/imx/linux-2.6 into next/defconfig
      Merge branch 'for-3.5/defconfig2' of git://git.kernel.org/.../swarren/linux-tegra into next/defconfig

Barry Song (1):
      ARM: PRIMA2: add prima2_defconfig for CSR SiRFprimaII

Fabio Estevam (2):
      ARM: imx_v4_v5_defconfig: Let CONFIG_MACH_IMX27_DT be built by default
      ARM: imx_v6_v7_defconfig: Add SPI NOR support

Laxman Dewangan (1):
      ARM: tegra: update defconfig

Olof Johansson (1):
      Merge branch 'for-3.5/defconfig' of git://git.kernel.org/.../swarren/linux-tegra into next/defconfig

Stephen Warren (1):
      ARM: tegra: update defconfig


 arch/arm/configs/imx_v4_v5_defconfig |  1 +
 arch/arm/configs/imx_v6_v7_defconfig |  6 +++
 arch/arm/configs/prima2_defconfig    | 69 +++++++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig     | 11 ++++-
 4 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/configs/prima2_defconfig
