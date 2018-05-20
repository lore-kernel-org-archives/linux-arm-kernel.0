From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 22:58:01 +0800
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.18
In-Reply-To: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
References: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1526828281-14664-5-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.18

for you to fetch changes up to 1049167999fc9a078c5914db9f341a275c2376cb:

  ARM: imx_v6_v7_defconfig: Select CONFIG_GPIO_MAX732X by default (2018-05-04 17:03:20 +0800)

----------------------------------------------------------------
i.MX defconfig update for 4.18:
 - Enable i.MX6SLL SoC support.
 - Build in GPIO_MAX732X support as the GPIO expanders are used on
   i.MX6 SabreAuto boards.
 - Enable driver for RN5T618 PMIC and Marvell MWIFIEX support which
   are found on i.MX6/7 Colibri boards.
 - Build in OCOTP NVMEM driver for Vybrid (vf610) SoCs.

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx_v6_v7_defconfig: Select CONFIG_GPIO_MAX732X by default

Bai Ping (1):
      ARM: imx_v6_v7_defconfig: enable imx6sll by default

Stefan Agner (3):
      ARM: imx_v6_v7_defconfig: add RN5T618 PMIC family support
      ARM: imx_v6_v7_defconfig: add mwifiex driver
      ARM: imx_v6_v7_defconfig: enable Vybrid OCOTP driver

 arch/arm/configs/imx_v6_v7_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)
