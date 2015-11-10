From: olof@lixom.net (Olof Johansson)
Date: Mon,  9 Nov 2015 19:33:24 -0800
Subject: [GIT PULL 6/6] ARM: SoC defconfig updates for v4.4
In-Reply-To: <1447126404-10567-1-git-send-email-olof@lixom.net>
References: <1447126404-10567-1-git-send-email-olof@lixom.net>
Message-ID: <1447126404-10567-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defconfig updates are kept separate from other branches mostly to avoid
conflicts between the different categories (driver branch enabling something
that has context conflict with SoC options, etc).

A lot of this again is scattered across the various hardware platforms.
multi_v7_defconfig, our "generic" config for most 32-bit platforms has
been gone through by Marvell Berlin maintainers and added most options
they need to run on their hardware. Broadcom NSP is also added there,
and the new Atmel SAMA5D2 (added last release). Rockchip also has display
and other devices supported in that config.

In addition to that, the usual small churn of new options being added
here and there.



Conflicts:

None

----------------------------------------------------------------

The following changes since commit 44f3e3191cc45643e19a3ac86eb6b4420bd48f33:

  Merge tag 'armsoc-dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to 7c9730c5684d8ffd69ee0b9e1739484cc6a35b23:

  ARM: multi_v7_defconfig: enable UniPhier I2C drivers

----------------------------------------------------------------

Alan Tull (1):
      ARM: socfpga_defconfig: enable fpga manager

Anand Moon (3):
      ARM: exynos_defconfig: Enable LEDS for Odroid-XU3/XU4
      ARM: exynos_defconfig: Enable rtl8152 ethernet driver for Odroid-XU4
      ARM: multi_v7_defconfig: Enable rtl8152 ethernet driver for Odroid-XU4

Andy Gross (3):
      ARM: qcom_defconfig: Enable SMD-RPM regulators
      ARM: multi_v7_defconfig: Enable QCOM SMD/RPM
      arm64: defconfig: Enable devices for MSM8916

Antoine Tenart (1):
      ARM: multi_v7_defconfig: improve multi_v7_defconfig support for Berlin

Arnd Bergmann (3):
      Merge tag 'renesas-defconfig-for-v4.4' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'arm-soc/for-4.4/defconfig' of http://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'keystone-config' of git://git.kernel.org/.../ssantosh/linux-keystone into next/defconfig

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Remove CONFIG_VMSPLIT_2G

Gerhard Bertelsmann (2):
      can: Allwinner A10/A20 CAN Controller support - Defconfig
      can: Allwinner A10/A20 CAN Controller support - Defconfig

Haibo Chen (1):
      ARM: imx_v6_v7_defconfig: enable imx6ul_tsc

Javier Martinez Canillas (3):
      ARM: exynos_defconfig: Enable USB Video Class support
      ARM: exynos_defconfig: Disable simplefb support
      ARM: exynos_defconfig: Enable WiFi-Ex as a module instead built-in

Joachim Eastwood (1):
      ARM: configs: update lpc18xx defconfig

Jon Mason (1):
      ARM: multi_v7_defconfig: Add NSP to defconfig

Jonathan Liu (1):
      ARM: sunxi_defconfig: enable MODULE_UNLOAD

Ludovic Desroches (6):
      ARM: at91/defconfig: update sama5 defconfig
      ARM: at91/defconfig: update at91_dt defconfig
      ARM: at91/defconfig: add sama5d2 and its new devices to sama5 defconfig
      ARM: multi_v7_defconfig: Add Atmel SAMA5D2 SoC
      ARM: multi_v7_defconfig: Add Atmel Flexcom device
      ARM: multi_v7_defconfig: Add Atmel SDHCI device

Magnus Damm (1):
      ARM: shmobile: Remove Marzen from shmobile_defconfig

Marcel Ziswiler (1):
      ARM: tegra: Update default configuration

Marek Szyprowski (2):
      ARM: exynos_defconfig: Enable DWC2 USB driver and USB ethernet gadget
      ARM: multi_v7_defconfig: Enable DWC2 USB driver and USB ethernet gadget

Masahiro Yamada (1):
      ARM: multi_v7_defconfig: enable UniPhier I2C drivers

Maxime Coquelin (1):
      ARM: configs: Enable FIXED_PHY in multi_v7 defconfig

Nishanth Menon (2):
      ARM: configs: keystone: sync to savedefconfig
      ARM: configs: keystone: Add basic systemd related options

Olof Johansson (9):
      Merge tag 'qcom-defconfig-for-4.4' of git://codeaurora.org/quic/kernel/agross-msm into next/defconfig
      Merge tag 'renesas-defconfig2-for-v4.4' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'socfpga_defconfig_for_v4.4' of git://git.kernel.org/.../dinguyen/linux into next/defconfig
      Merge tag 'mvebu-config-4.4-1' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'sunxi-defconfig-for-4.4' of https://git.kernel.org/.../mripard/linux into next/defconfig
      Merge tag 'imx-defconfig-4.4' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'at91-ab-defconfig' of git://git.kernel.org/.../abelloni/linux into next/defconfig
      Merge tag 'tegra-for-4.4-defconfig' of git://git.kernel.org/.../tegra/linux into next/defconfig
      Merge tag 'samsung-defconfig' of git://git.kernel.org/.../kgene/linux-samsung into next/defconfig

Priit Laes (1):
      ARM: sunxi_defconfig: Enable LRADC keys (KEYBOARD_SUN4I_LRADC)

Simon Guinot (1):
      ARM: mvebu: enable options for Seagate NAS in mvebu_v7_defconfig

Simon Horman (1):
      ARM: multi_v7_defconfig: Remove Marzen

Sjoerd Simons (5):
      ARM: multi_v7_defconfig: Enable common Rockchip devices/busses
      ARM: multi_v7_defconfig: Enable common regulators for rockchip boards
      ARM: multi_v7_defconfig: Enable Rockchip display support
      ARM: multi_v7_defconfig: Enable the Rockchip USB 2.0 phy
      ARM: multi_v7_defconfig: Support RTC devices commonly used on Rockchip boards

Srinivas Kandagatla (1):
      ARM: multi_v7_defconfig: Add missing QCOM APQ8064 configs

Thierry Reding (2):
      ARM: tegra: Rebuild default configuration on v4.3-rc1
      ARM: tegra: Update multi_v7_defconfig

Wolfram Sang (2):
      ARM: shmobile: defconfig: enable HDMI output for RCar
      ARM: multi_v7_defconfig: enable HDMI output for Renesas RCar


 arch/arm/configs/at91_dt_defconfig   | 15 ---------
 arch/arm/configs/exynos_defconfig    | 18 +++++++++--
 arch/arm/configs/imx_v6_v7_defconfig |  2 +-
 arch/arm/configs/keystone_defconfig  | 54 +++++++++++++++----------------
 arch/arm/configs/lpc18xx_defconfig   | 26 ++++++++++++---
 arch/arm/configs/multi_v7_defconfig  | 48 ++++++++++++++++++++++++++-
 arch/arm/configs/mvebu_v7_defconfig  |  9 +++++-
 arch/arm/configs/qcom_defconfig      |  8 +++--
 arch/arm/configs/sama5_defconfig     | 16 ++++-----
 arch/arm/configs/shmobile_defconfig  |  4 ++-
 arch/arm/configs/socfpga_defconfig   |  2 ++
 arch/arm/configs/sunxi_defconfig     |  4 +++
 arch/arm/configs/tegra_defconfig     | 10 ++++--
 arch/arm64/configs/defconfig         | 10 ++++++
 14 files changed, 157 insertions(+), 69 deletions(-)
