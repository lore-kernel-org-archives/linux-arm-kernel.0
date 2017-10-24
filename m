From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Oct 2017 20:20:45 +0800
Subject: [GIT PULL 4/4] i.MX defconfig updates for 4.15
In-Reply-To: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
References: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1508847645-9191-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.15

for you to fetch changes up to a8ca183dc8c4e98980007ed8b8ccc7992cbad4ea:

  ARM: imx_v6_v7_defconfig: Select the CEC driver (2017-10-13 11:27:31 +0800)

----------------------------------------------------------------
i.MX defconfig updates for 4.15:
 - Turn on DRM_DW_HDMI_CEC option to get HDMI CEC support.
 - Enable MUX_MMIO to get ADV7180 probe on Gateworks GW51xx boards.

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Select CONFIG_MUX_MMIO
      ARM: imx_v6_v7_defconfig: Select the CEC driver

 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)
