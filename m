From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2016 02:31:12 +0200
Subject: [GIT PULL 3/8] ARM: SoC defconfig changes for v4.9
In-Reply-To: <3637015.LRn5VyhPVM@wuerfel>
References: <3637015.LRn5VyhPVM@wuerfel>
Message-ID: <19964061.WQ4GtRfllB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:

  Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to 3f0958d8aea708019d52962a7a8fe827d9f9006c:

  ARM: multi_v7_defconfig: enable CONFIG_EFI (2016-09-19 17:16:34 +0200)

----------------------------------------------------------------
ARM: SoC defconfig updates for v4.9

Defconfig additions, removals, etc. Most of these are small changes adding
the options for newly upstreamed drivers, or drivers needed for new board
support. Nothing specifically sticks out this time.

----------------------------------------------------------------
Ard Biesheuvel (1):
      ARM: multi_v7_defconfig: enable CONFIG_EFI

Arnd Bergmann (6):
      Merge tag 'davinci-for-v4.9/defconfig' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'samsung-defconfig-4.9' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'omap-for-v4.9/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'keystone_config_for_4.9' of git://git.kernel.org/.../ssantosh/linux-keystone into next/defconfig
      Merge tag 'mvebu-defconfig-4.9-1' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'imx-defconfig-4.9' of git://git.kernel.org/.../shawnguo/linux into next/defconfig

Borislav Petkov (1):
      ARM: s3c2410_defconfig: Remove CONFIG_IPV6_PRIVACY

Breno Lima (1):
      ARM: imx_v6_v7_defconfig: Add CONFIG_MPL3115

Chanwoo Choi (1):
      ARM: exynos_defconfig: Enable bus frequency scaling with devfreq

Fabian Frederick (1):
      ARM: mvebu_v5_defconfig: use MV88E6XXX

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Enable GPU support
      ARM: imx_v6_v7_defconfig: Select the wm8960 codec driver

Grzegorz Jaszczyk (2):
      ARM: mvebu: enable MTD command line partition table in mvebu_v7_defconfig
      ARM: mvebu: enable UBI and UBIFS in mvebu_v7_defconfig

Javier Martinez Canillas (1):
      ARM: multi_v7_defconfig: Build Atmel maXTouch driver as a module

Karl Beldan (4):
      ARM: davinci_all_defconfig: enable RTC driver as module
      ARM: davinci_all_defconfig: enable SMSC ethernet PHY
      ARM: davinci_all_defconfig: Enable AEMIF as a module
      ARM: davinci_all_defconfig: Enable some UBI modules

Kevin Hilman (2):
      ARM: davinci_all_defconfig: cleanup with savedefconfig
      ARM: davinci_all_defconfig: enable DA850 audio as modules

Krzysztof Kozlowski (4):
      ARM: exynos_defconfig: Enable PM_DEBUG
      ARM: exynos_defconfig: Enable SECCOMP
      ARM: multi_v7_defconfig: Enable SECCOMP
      Merge tag 'tags/samsung-defconfig-schedutil-4.9' into next/defconfig

Linus Walleij (2):
      ARM: omap2plus_defconfig: switch to the IIO BMP085 driver
      ARM: defconfig: update the Integrator defconfig

Peter Chen (1):
      ARM: imx_v6_v7_defconfig: enable more USB configurations

Roger Quadros (1):
      ARM: keystone: defconfig: Fix USB configuration

Tuomas Tynkkynen (2):
      ARM: multi_v7_defconfig: Enable AHCI_IMX
      ARM: multi_v7_defconfig: Enable ARM_IMX6Q_CPUFREQ

 arch/arm/configs/davinci_all_defconfig | 66 +++++++++++++---------------------
 arch/arm/configs/exynos_defconfig      | 11 +++++-
 arch/arm/configs/imx_v6_v7_defconfig   | 17 +++++----
 arch/arm/configs/integrator_defconfig  | 13 ++-----
 arch/arm/configs/keystone_defconfig    |  1 +
 arch/arm/configs/multi_v7_defconfig    | 13 +++++--
 arch/arm/configs/mvebu_v5_defconfig    |  5 +--
 arch/arm/configs/mvebu_v7_defconfig    |  3 ++
 arch/arm/configs/omap2plus_defconfig   |  2 +-
 arch/arm/configs/s3c2410_defconfig     |  1 -
 10 files changed, 66 insertions(+), 66 deletions(-)
