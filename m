From: shawnguo@kernel.org (Shawn Guo)
Date: Tue,  3 May 2016 23:58:05 +0800
Subject: [GIT PULL 5/6] i.MX defconfig updates for 4.7
In-Reply-To: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
References: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1462291086-19925-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.7

for you to fetch changes up to 2ead04d9d69ebded61da063cb5a8ade72da6c8f5:

  ARM: imx_v6_v7_defconfig: add CONFIG_MICREL_PHY (2016-05-03 20:58:07 +0800)

----------------------------------------------------------------
The i.MX defconfig updates for 4.7:
 - Update multi_v5_defconfig for i.MX21/27 and systemd support
 - Update imx_v6_v7_defconfig to support devices found on various i.MX6
   board: FT5x06 and TSC2004 touch, I2C GPIO, MICREL PHY and M41T80 RTC

----------------------------------------------------------------
Gary Bisson (3):
      ARM: imx_v6_v7_defconfig: add FT5x06 and TSC2004 touch support
      ARM: imx_v6_v7_defconfig: add CONFIG_I2C_MUX_GPIO
      ARM: imx_v6_v7_defconfig: add CONFIG_RTC_DRV_M41T80

Jan Luebbe (2):
      ARM: multi_v5_defconfig: Enable support for MX21/MX27
      ARM: multi_v5_defconfig: Enable recommended options for systemd

Marcel Ziswiler (2):
      ARM: imx_v6_v7_defconfig: add CONFIG_I2C_GPIO
      ARM: imx_v6_v7_defconfig: add CONFIG_MICREL_PHY

 arch/arm/configs/imx_v6_v7_defconfig |  6 ++++++
 arch/arm/configs/multi_v5_defconfig  | 21 ++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)
