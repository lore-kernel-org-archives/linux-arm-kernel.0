From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 19 Jun 2017 18:05:09 +0200
Subject: [GIT PULL 2/2] ARM: defconfig: Topic branch with defconfig cleanup
 for v4.13
In-Reply-To: <20170619160509.5065-1-krzk@kernel.org>
References: <20170619160509.5065-1-krzk@kernel.org>
Message-ID: <20170619160509.5065-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are ARM changes to defconfig from my cleanup patchset:
https://www.spinics.net/lists/mips/msg68188.html


Best regards,
Krzysztof


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.13-2

for you to fetch changes up to 794b77738c0dede15441209a56044fd67c48a200:

  ARM: tct_hammer_defconfig: Save defconfig (2017-06-10 19:30:23 +0200)

----------------------------------------------------------------
ARM defconfig cleanup:
1. Remove old Kconfig options from all ARM configs,
2. Update Samsung defconfigs to bring back options over time got disabled
   for some reason (configs were not updated along with the code),
3. Save defconfigs for Samsung.

----------------------------------------------------------------
Krzysztof Kozlowski (13):
      ARM: defconfig: Cleanup from old Kconfig options
      ARM: defconfig: samsung: Re-order entries to match savedefconfig
      ARM: mini2440_defconfig: Bring back lost (but wanted) options
      ARM: tct_hammer_defconfig: Bring back lost (but wanted) options
      ARM: s3c2410_defconfig: Bring back lost (but wanted) options
      ARM: s3c6400_defconfig: Bring back lost (but wanted) options
      ARM: s5pv210_defconfig: Bring back lost (but wanted) options
      ARM: exynos_defconfig: Save defconfig
      ARM: s3c2410_defconfig: Save defconfig
      ARM: mini2440_defconfig: Save defconfig
      ARM: s3c6400_defconfig: Save defconfig
      ARM: s5pv210_defconfig: Save defconfig
      ARM: tct_hammer_defconfig: Save defconfig

 arch/arm/configs/acs5k_defconfig          |  8 ---
 arch/arm/configs/acs5k_tiny_defconfig     | 10 ----
 arch/arm/configs/am200epdkit_defconfig    |  7 ---
 arch/arm/configs/assabet_defconfig        |  3 -
 arch/arm/configs/axm55xx_defconfig        |  1 -
 arch/arm/configs/badge4_defconfig         |  5 --
 arch/arm/configs/cerfcube_defconfig       |  4 --
 arch/arm/configs/cm_x2xx_defconfig        | 13 -----
 arch/arm/configs/cm_x300_defconfig        | 10 ----
 arch/arm/configs/cns3420vb_defconfig      |  7 ---
 arch/arm/configs/colibri_pxa270_defconfig | 13 -----
 arch/arm/configs/colibri_pxa300_defconfig |  9 ---
 arch/arm/configs/collie_defconfig         |  4 --
 arch/arm/configs/corgi_defconfig          | 13 -----
 arch/arm/configs/dove_defconfig           |  1 -
 arch/arm/configs/ebsa110_defconfig        |  1 -
 arch/arm/configs/efm32_defconfig          |  1 -
 arch/arm/configs/em_x270_defconfig        | 13 -----
 arch/arm/configs/ep93xx_defconfig         |  1 -
 arch/arm/configs/eseries_pxa_defconfig    |  8 ---
 arch/arm/configs/exynos_defconfig         |  6 +-
 arch/arm/configs/ezx_defconfig            | 18 ------
 arch/arm/configs/footbridge_defconfig     |  1 -
 arch/arm/configs/h5000_defconfig          |  6 --
 arch/arm/configs/hackkit_defconfig        |  3 -
 arch/arm/configs/imote2_defconfig         | 16 ------
 arch/arm/configs/imx_v4_v5_defconfig      |  1 -
 arch/arm/configs/iop13xx_defconfig        |  4 --
 arch/arm/configs/iop32x_defconfig         |  5 --
 arch/arm/configs/iop33x_defconfig         |  6 --
 arch/arm/configs/ixp4xx_defconfig         |  9 ---
 arch/arm/configs/jornada720_defconfig     |  8 ---
 arch/arm/configs/ks8695_defconfig         |  7 ---
 arch/arm/configs/lart_defconfig           |  3 -
 arch/arm/configs/lpc18xx_defconfig        |  1 -
 arch/arm/configs/lpd270_defconfig         |  5 --
 arch/arm/configs/lubbock_defconfig        |  4 --
 arch/arm/configs/magician_defconfig       | 15 -----
 arch/arm/configs/mainstone_defconfig      |  4 --
 arch/arm/configs/mini2440_defconfig       | 91 +++++++++----------------------
 arch/arm/configs/mmp2_defconfig           |  9 ---
 arch/arm/configs/moxart_defconfig         |  1 -
 arch/arm/configs/mps2_defconfig           |  1 -
 arch/arm/configs/mv78xx0_defconfig        |  8 ---
 arch/arm/configs/mxs_defconfig            |  1 -
 arch/arm/configs/neponset_defconfig       |  4 --
 arch/arm/configs/netwinder_defconfig      |  3 -
 arch/arm/configs/netx_defconfig           |  6 --
 arch/arm/configs/nhk8815_defconfig        |  1 -
 arch/arm/configs/nuc910_defconfig         |  7 ---
 arch/arm/configs/nuc950_defconfig         |  7 ---
 arch/arm/configs/nuc960_defconfig         |  7 ---
 arch/arm/configs/omap1_defconfig          |  2 -
 arch/arm/configs/orion5x_defconfig        |  2 -
 arch/arm/configs/palmz72_defconfig        |  6 --
 arch/arm/configs/pcm027_defconfig         |  8 ---
 arch/arm/configs/pleb_defconfig           |  3 -
 arch/arm/configs/pxa168_defconfig         |  9 ---
 arch/arm/configs/pxa255-idp_defconfig     |  4 --
 arch/arm/configs/pxa3xx_defconfig         |  9 ---
 arch/arm/configs/pxa910_defconfig         |  9 ---
 arch/arm/configs/pxa_defconfig            |  2 -
 arch/arm/configs/qcom_defconfig           |  1 -
 arch/arm/configs/raumfeld_defconfig       | 11 ----
 arch/arm/configs/realview_defconfig       |  1 -
 arch/arm/configs/rpc_defconfig            |  6 --
 arch/arm/configs/s3c2410_defconfig        | 38 +++----------
 arch/arm/configs/s3c6400_defconfig        | 18 ++----
 arch/arm/configs/s5pv210_defconfig        | 28 +++-------
 arch/arm/configs/sama5_defconfig          |  1 -
 arch/arm/configs/shannon_defconfig        |  3 -
 arch/arm/configs/simpad_defconfig         |  7 ---
 arch/arm/configs/spear13xx_defconfig      |  4 --
 arch/arm/configs/spear3xx_defconfig       |  4 --
 arch/arm/configs/spear6xx_defconfig       |  3 -
 arch/arm/configs/spitz_defconfig          | 13 -----
 arch/arm/configs/sunxi_defconfig          |  1 -
 arch/arm/configs/tct_hammer_defconfig     | 15 +----
 arch/arm/configs/trizeps4_defconfig       |  8 ---
 arch/arm/configs/u300_defconfig           |  1 -
 arch/arm/configs/vexpress_defconfig       |  1 -
 arch/arm/configs/viper_defconfig          |  9 ---
 arch/arm/configs/xcep_defconfig           |  8 ---
 arch/arm/configs/zeus_defconfig           | 10 ----
 arch/arm/configs/zx_defconfig             |  2 -
 85 files changed, 52 insertions(+), 595 deletions(-)
