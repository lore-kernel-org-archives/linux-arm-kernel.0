From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Sep 2016 17:02:28 +0800
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.9
In-Reply-To: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1473670948-4265-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.9

for you to fetch changes up to b2ab6f6cc3b1da42acf30e03ce2a4dad3f627272:

  ARM: imx_v6_v7_defconfig: Select the wm8960 codec driver (2016-08-29 22:17:26 +0800)

----------------------------------------------------------------
i.MX defconfig updates for 4.9:
 - Enable i.MX6 SATA and cpufreq driver support in multi_v7_defconfig.
 - Enable MPL3115, Etnaviv GPU, WM8960 Codec driver and more USB
   functions support in imx_v6_v7_defconfig.

----------------------------------------------------------------
Breno Lima (1):
      ARM: imx_v6_v7_defconfig: Add CONFIG_MPL3115

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Enable GPU support
      ARM: imx_v6_v7_defconfig: Select the wm8960 codec driver

Peter Chen (1):
      ARM: imx_v6_v7_defconfig: enable more USB configurations

Tuomas Tynkkynen (2):
      ARM: multi_v7_defconfig: Enable AHCI_IMX
      ARM: multi_v7_defconfig: Enable ARM_IMX6Q_CPUFREQ

 arch/arm/configs/imx_v6_v7_defconfig | 17 +++++++++++------
 arch/arm/configs/multi_v7_defconfig  |  3 +++
 2 files changed, 14 insertions(+), 6 deletions(-)
