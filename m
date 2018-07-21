From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 21 Jul 2018 10:37:51 +0800
Subject: [GIT PULL 6/6] i.MX defconfig updates for 4.19
In-Reply-To: <1532140671-2869-1-git-send-email-shawnguo@kernel.org>
References: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
 <1532140671-2869-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1532140671-2869-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.19

for you to fetch changes up to eaed0291c62f7b513ad9483b02efdccd4ae4e9fc:

  ARM: imx_v6_v7_defconfig: add DMATEST support (2018-07-21 09:58:21 +0800)

----------------------------------------------------------------
i.MX defconfig update for 4.19:
 - Enable ISL29018 sensor and MMA8452 accelerometer driver support for
   imx6qdl-sabreauto board.
 - Enable DMATEST support which is useful for DMA driver development
   testing.
 - Use the DRM driver for MXSFB LCD controller found on i.MX23, i.MX28,
   i.MX6SX and i.MX7 SoCs.

----------------------------------------------------------------
Leonard Crestez (1):
      ARM: imx_v6_v7_defconfig: Enable imx6qdl-sabreauto sensors

Robin Gong (1):
      ARM: imx_v6_v7_defconfig: add DMATEST support

Stefan Agner (2):
      ARM: mxs_defconfig: use MXSFB DRM driver
      ARM: imx_v6_v7_defconfig: use MXSFB DRM driver

 arch/arm/configs/imx_v6_v7_defconfig | 8 +++++---
 arch/arm/configs/mxs_defconfig       | 5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)
