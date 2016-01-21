From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:41 -0800
Subject: [GIT PULL 8/9] ARM: 64-bit defconfig updates for v4.5
In-Reply-To: <1453338882-31300-1-git-send-email-olof@lixom.net>
References: <1453338882-31300-1-git-send-email-olof@lixom.net>
Message-ID: <1453338882-31300-9-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As mentioned earlier, we usually bake this into the general "arm64" branch,
but this release we have partitioned up the updates a bit more.

Most of these updates are enabling new SoCs in the single defconfig for 64-bit,
Renesas R8A7795, a number of Tegra options, Socionext Uniphier and a handful
of new options for other platforms as well.

----------------------------------------------------------------

The following changes since commit 6735a8e199d639b39ca1dbbcd5c90be8bb58b46d:

  Merge branch 'next/defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig64

for you to fetch changes up to a25682e2a19788ca1fc989ea079db8c5609cb885:

  Merge tag 'v4.4-next-kconfig' of https://github.com/mbgg/linux-mediatek into next/config64

----------------------------------------------------------------

Arnd Bergmann (3):
      Merge tag 'renesas-arm64-defconfig-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/config64
      Merge tag 'renesas-arm64-defconfig2-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/config64
      Merge tag 'berlin64-soc-for-4.5-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/config64

Jisheng Zhang (1):
      arm64: berlin: add the pinctrl dependency for Marvell Berlin SoCs

Kouei Abe (1):
      arm64: defconfig: Add Renesas R-Car SATA driver for R-Car Gen3 SoCs

Kuninori Morimoto (5):
      arm64: defconfig: renesas: Enable Renesas r8a7795 SoC
      arm64: defconfig: Enable Renesas R-Car I2C Controller
      arm64: defconfig: add Renesas R-Car DMAC driver support
      arm64: defconfig: add Renesas sound and AK4613 support
      arm64: defconfig: add CS2000 support

Masahiro Yamada (2):
      arm64: add Kconfig entry for Socionext UniPhier SoC family
      arm64: defconfig: enable UniPhier SoCs support

Olof Johansson (3):
      Merge tag 'tegra-for-4.5-defconfig' of git://git.kernel.org/.../tegra/linux into next/config64
      Merge tag 'renesas-arm64-defconfig3-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/config64
      Merge tag 'v4.4-next-kconfig' of https://github.com/mbgg/linux-mediatek into next/config64

Simon Horman (1):
      arm64: defconfig: enable EthernetAVB

Takeshi Kihara (1):
      arm64: defconfig: Enable GPIO of Renesas R-Car Gen3 SoC

Thierry Reding (7):
      arm64: defconfig: Enable Tegra210 support
      arm64: defconfig: Do not disable Tegra AHB driver
      arm64: defconfig: Enable tegra-apbdma driver
      arm64: defconfig: Enable serial-tegra driver
      arm64: defconfig: Enable sdhci-tegra driver
      arm64: defconfig: Enable squashfs support
      arm64: defconfig: Enable printk timestamps

Yingjoe Chen (1):
      arm64: mediatek: enable MTK_TIMER


 arch/arm64/Kconfig.platforms |  8 ++++++++
 arch/arm64/configs/defconfig | 27 +++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)
