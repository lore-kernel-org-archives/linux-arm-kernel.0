From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 22:58:00 +0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.18
In-Reply-To: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
References: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1526828281-14664-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.18

for you to fetch changes up to 70ce60431e45ace2a1198d4cf339beaef1de9f8b:

  arm64: dts: fsl-ls1012a: Fix DTC aliases warnings (2018-05-15 14:43:58 +0800)

----------------------------------------------------------------
Freescale arm64 device tree update for 4.18:
 - Add unit address for ls208xa-rdb SPI flash node matching 'reg'
   property to fix DTC warning unit_address_vs_reg.
 - Use hypen instead of underscore in aliases name for fsl-ls1012a to
   fix DTC warning alias_paths.

----------------------------------------------------------------
Fabio Estevam (2):
      arm64: dts: ls208xa-rdb: Pass unit name to SPI flash node
      arm64: dts: fsl-ls1012a: Fix DTC aliases warnings

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 10 +++++-----
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)
