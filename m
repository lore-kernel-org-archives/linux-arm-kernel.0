From: shawnguo@kernel.org (Shawn Guo)
Date: Tue,  1 Mar 2016 23:00:03 +0800
Subject: [GIT PULL 4/4] ARM: imx: defconfig updates for 4.6
In-Reply-To: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
References: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1456844403-26176-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.6

for you to fetch changes up to c73a1f13d07fc89734f28760554fc365b91c750a:

  ARM: imx_v4_v5_defconfig: Enable initramfs support (2016-03-01 21:32:51 +0800)

----------------------------------------------------------------
The i.MX defconfig update for 4.6:
- Enable i.MX25 Touchscreen controller and ADC support
- Enable NVMEM OCOTP driver support
- Clean up mxs_defconfig and imx_v4_v5_defconfig
- Enable initramfs support
- Enable PSCI, SAHARA and more Vybrid driver support

----------------------------------------------------------------
Denis Carikli (1):
      ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller and ADC support.

Fabio Estevam (3):
      ARM: imx_v6_v7_defconfig: Select CONFIG_NVMEM_IMX_OCOTP
      ARM: mxs_defconfig: Select CONFIG_NVMEM_MXS_OCOTP
      ARM: imx_v6_v7_defconfig: Select CONFIG_CRYPTO_DEV_SAHARA

Frank Li (1):
      ARM: imx_v6_v7_defconfig: enable psci default

Jan Luebbe (4):
      ARM: mxs_defconfig: Cleanup mxs_defconfig
      ARM: mxs_defconfig: Enable initramfs support
      ARM: imx_v4_v5_defconfig: Cleanup imx_v4_v5_defconfig
      ARM: imx_v4_v5_defconfig: Enable initramfs support

Stefan Agner (1):
      ARM: imx_v6_v7_defconfig: enable useful configurations for Vybrid

 arch/arm/configs/imx_v4_v5_defconfig | 14 +++++++-------
 arch/arm/configs/imx_v6_v7_defconfig | 23 +++++++++++++++--------
 arch/arm/configs/mxs_defconfig       |  7 +++----
 3 files changed, 25 insertions(+), 19 deletions(-)
