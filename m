From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Mar 2018 19:36:40 +0800
Subject: [GIT PULL 6/6] i.MX defconfig updates for 4.17
In-Reply-To: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1521113800-16401-6-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.17

for you to fetch changes up to e3e583e7a293ae3fddfe010ed30d80046ba87c86:

  ARM: mxs_defconfig: Re-sync defconfig (2018-03-08 16:46:11 +0800)

----------------------------------------------------------------
i.MX defconfig updates for 4.17:
 - Re-sync defconfig files by running savedefconfig.
 - Enable generic fsl-asoc-card driver for imx_v4_v5_defconfig.
 - Enable MAG3110 magnetometer sensor driver, AC97 and WM8962 codec
   driver, DA9062/63 PMIC, RTC and Watchdog support for
   imx_v6_v7_defconfig.

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx_v6_v7_defconfig: select the CONFIG_CPUFREQ_DT

Fabio Estevam (5):
      ARM: imx_v6_v7_defconfig: Enable AC97 codec support
      ARM: imx_v6_v7_defconfig: Re-sync defconfig
      ARM: imx_v6_v7_defconfig: Select CONFIG_SND_SOC_WM8962 explicitly
      ARM: imx_v4_v5_defconfig: Use the generic fsl-asoc-card driver
      ARM: mxs_defconfig: Re-sync defconfig

Marco Franchi (1):
      ARM: imx: Update imx_v6_v7_defconfig for mag3110 support

Peng Fan (1):
      ARM: imx_v6_v7_defconfig: enable OP-TEE

Stefan Riedmueller (1):
      ARM: imx_v6_v7_defconfig: Enable Dialog Semiconductor DA9062 driver

fabio.estevam at nxp.com (1):
      ARM: imx_v4_v5_defconfig: Re-sync defconfig

 arch/arm/configs/imx_v4_v5_defconfig |  9 +++------
 arch/arm/configs/imx_v6_v7_defconfig | 28 +++++++++++++++-------------
 arch/arm/configs/mxs_defconfig       | 14 +++-----------
 3 files changed, 21 insertions(+), 30 deletions(-)
