From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Oct 2018 22:21:22 +0100
Subject: [GIT PULL 2/4] ARM: SoC defconfig updates for 4.20
In-Reply-To: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
References: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
Message-ID: <CAK8P3a2Q8Dfm+UAnL3pRZOeHJbeOcefQ1e2c5mFuNtnZ2ZQc=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-defconfig

for you to fetch changes up to e8c3f6322cc853084a6d63244c15fb0251090327:

  Merge tag 'imx-defconfig-4.20' of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
next/defconfig (2018-10-11 15:24:50 +0200)

----------------------------------------------------------------
ARM: SoC defconfig updates for 4.20

The defconfig changes are split out from the rest again. This time we
have a number of changes for NXP i.MX and Renesas, including a cleanup of
old options.

Some smaller changes are for Socionext Uniphier, Allwinner, Qualcomm,
Rockchip, Renesas, AT91, Hisilicon, and STM32. All of these just enable
platform specific device drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Amelie Delaunay (1):
      ARM: multi_v7_defconfig: enable STM32 SPI

Anson Huang (1):
      ARM: imx_v6_v7_defconfig: select CONFIG_ARM_CPUIDLE by default

Arnd Bergmann (7):
      Merge tag 'renesas-arm64-defconfig-for-v4.20' of
git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'renesas-arm-defconfig-for-v4.20' of
git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'qcom-arm64-defconfig-for-4.20' of
git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'qcom-defconfig-for-4.20' of
git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'sunxi-config64-for-4.20' of
git://git.kernel.org/.../sunxi/linux into next/defconfig
      Merge tag 'v4.20-rockchip-defconfig64-1' of
git://git.kernel.org/.../mmind/linux-rockchip into next/defconfig
      Merge tag 'imx-defconfig-4.20' of
git://git.kernel.org/.../shawnguo/linux into next/defconfig

Biju Das (3):
      arm64: defconfig: enable R8A774A1 SoC
      ARM: multi_v7_defconfig: Enable r8a7744 SoC
      ARM: shmobile: defconfig: Enable r8a7744 SoC

Bjorn Andersson (1):
      arm64: defconfig: Enable Qualcomm QRTR

Codrin Ciubotariu (2):
      ARM: configs: at91: Add I2S driver to sama5
      ARM: multi_v7_defconfig: add Atmel I2S driver

Dongdong Liu (1):
      arm64: defconfig: Enable PCIEPORTBUS

Eugen Hristev (2):
      ARM: configs: at91: add generic resistive touchscreen to sama5
      ARM: multi_v7_defconfig: add generic resistive touchscreen

Fabio Estevam (8):
      ARM: imx_v6_v7_defconfig: Select CONFIG_SENSORS_MC13783_ADC
      ARM: imx_v6_v7_defconfig: Re-sync defconfig
      ARM: imx_v6_v7_defconfig: Remove unneeded options
      ARM: mxs_defconfig: Re-sync defconfig
      ARM: mxs_defconfig: Remove unneeded options
      ARM: imx_v4_v5_defconfig: Re-sync defconfig
      ARM: imx_v4_v5_defconfig: Remove unneeded options
      ARM: imx_v6_v7_defconfig: Select CONFIG_TMPFS_POSIX_ACL

Fabrizio Castro (1):
      arm64: defconfig: enable R8A774C0 SoC

Frank Rowand (1):
      ARM: qcom_defconfig: Enable MAILBOX

Geert Uytterhoeven (3):
      ARM: shmobile: defconfig: Refresh shmobile_defconfig for v4.19-rc1
      ARM: shmobile: defconfig: Enable VIDEO_RENESAS_FDP1
      ARM: multi_v7_defconfig: Enable VIDEO_RENESAS_FDP1

Heiko Stuebner (1):
      arm64: defconfig: enable Rockchip Innosilicon hdmiphy

Jacopo Mondi (1):
      ARM: shmobile: defconfig: Remove SOC_CAMERA

Jagan Teki (1):
      arm64: defconfig: Enable CONFIG_DRM_SUN4I

Kunihiko Hayashi (2):
      arm64: defconfig: Enable USB phys for UniPhier SoCs
      ARM: multi_v7_defconfig: Enable USB phys for UniPhier SoCs

Leonard Crestez (1):
      ARM: imx_v6_v7_defconfig: Make usbnet drivers builtin for boot

Lokesh Vutla (2):
      arm64: defconfig: Enable TI_SCI related configs
      arm64: defconfig: Enable SERIAL_8250_OMAP

Masahiro Yamada (2):
      arm64: defconfig: enable CONFIG_MMC_UNIPHIER
      ARM: multi_v7_defconfig: enable CONFIG_MMC_UNIPHIER

Olof Johansson (4):
      Merge tag 'arm-soc/for-4.20/defconfig' of
https://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'stm32-defconfig-for-v4.20-1' of
git://git.kernel.org/.../atorgue/stm32 into next/defconfig
      Merge tag 'hisi-defconfig-for-4.20' of
git://github.com/hisilicon/linux-hisi into next/defconfig
      Merge tag 'at91-4.20-defconfig' of
git://git.kernel.org/.../at91/linux into next/defconfig

Robin Gong (1):
      ARM: imx_v6_v7_defconfig: add CONFIG_FW_LOADER_USER_HELPER

Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable bcm2835-audio

Yannick Fertr? (3):
      ARM: multi_v7_defconfig: enable STM32 DRM and MIPI DSI support
      ARM: multi_v7_defconfig: enable panels OTM8009A and RM68200
      ARM: multi_v7_defconfig: enable backlight gpio

Zhou Wang (1):
      arm64: defconfig: enable HiSilicon HNS3 driver

 arch/arm/configs/bcm2835_defconfig   |  2 +-
 arch/arm/configs/imx_v4_v5_defconfig | 18 +++++++---------
 arch/arm/configs/imx_v6_v7_defconfig | 41 ++++++++++++++++++++----------------
 arch/arm/configs/multi_v7_defconfig  | 13 ++++++++++++
 arch/arm/configs/mxs_defconfig       | 19 +++++++----------
 arch/arm/configs/qcom_defconfig      |  1 +
 arch/arm/configs/sama5_defconfig     |  2 ++
 arch/arm/configs/shmobile_defconfig  |  8 +++----
 arch/arm64/configs/defconfig         | 20 ++++++++++++++++++
 9 files changed, 79 insertions(+), 45 deletions(-)
