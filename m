From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 21:12:21 +0100
Subject: [PATCH 0/9] Regenerate arm64 defconfig for current kernel
Message-ID: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ARM maintainers,

The set of Kconfig options slowly changes with every kernel version.
This patch series regenerates the arm64 defconfig for v4.20
No functional change intended, except adding PINCTRL_MTK_MOORE to
keep PINCTRL_MT7622.

Marc Gonzalez (9):
  arm64: defconfig: Regenerate for v4.20
  arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
  arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
  arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
  arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
  arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
  arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
  arm64: defconfig: Change SCSI_UFS_HISI=m
  arm64: defconfig: Drop redundant sound codec options

 arch/arm64/configs/defconfig | 105 +++++++++++++++--------------------
 1 file changed, 46 insertions(+), 59 deletions(-)

-- 
2.17.1
