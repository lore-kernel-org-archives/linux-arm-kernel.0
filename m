From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Sep 2018 22:59:41 +0200
Subject: [GIT PULL 4/5] ARM: tegra: Device tree changes for v4.20-rc1
In-Reply-To: <20180927205942.30878-1-thierry.reding@gmail.com>
References: <20180927205942.30878-1-thierry.reding@gmail.com>
Message-ID: <20180927205942.30878-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.20-arm-dt

for you to fetch changes up to ebea2a43fdafdbce918bd7e200b709d6c33b9f3b:

  ARM: dts: paz00: fix wakeup gpio keycode (2018-09-26 17:29:41 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.20-rc1

This contains a massive amount of changes from Marcel Ziswiler for
various boards by Toradex.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: tegra: tegra20: Fix mixed tabs-spaces indentation

Marc Dietrich (1):
      ARM: dts: paz00: fix wakeup gpio keycode

Marcel Ziswiler (127):
      ARM: dts: tegra30: fix xcvr-setup-use-fuses
      ARM: dts: tegra20: restore address order
      ARM: dts: tegra20/tegra30: add pmu interrupt-affinity
      ARM: tegra: apalis_t30: fix mmc1 cmd pull-up
      ARM: tegra: apalis_t30: pull-up sd card detect pins
      ARM: tegra: apalis_t30: add local-mac-address property
      ARM: tegra: apalis_t30: reorder pcie properties
      ARM: tegra: apalis_t30: annotate/clean-up pcie controller/port nodes
      ARM: tegra: apalis_t30: reorder host1x/hdmi properties
      ARM: tegra: apalis_t30: regulator clean-up
      ARM: tegra: apalis_t30: add missing regulators
      ARM: tegra: apalis_t30: annotate uarts and move compatible to board
      ARM: tegra: apalis_t30: drop unused cami2c label
      ARM: tegra: apalis_t30: white-space/newline clean-up
      ARM: tegra: apalis_t30: drop unused mmc1/sd1 labels
      ARM: tegra: apalis_t30: annotate mmc1/sd1
      ARM: tegra: apalis_t30: move dr_mode property from phy to controller
      ARM: tegra: apalis_t30: reorder backlight properties
      ARM: tegra: apalis_t30: drop pwmleds
      ARM: tegra: apalis_t30: pinmux clean-up
      ARM: tegra: apalis_t30: add missing pinmux
      ARM: tegra: apalis_t30: use proper irq-gpio for stmpe811
      ARM: tegra: apalis_t30: further lm95245 temperature sensor annotation
      ARM: tegra: apalis_t30: add i2c-thermtrip
      ARM: tegra: apalis_t30: add proper emmc vmmc and vqmmc supplies
      ARM: tegra: apalis_t30: enable emmc ddr52 mode
      ARM: tegra: apalis_t30: get rid of fake clocks simple bus
      ARM: tegra: apalis_t30: line break long compatible property line
      dt-bindings: add broadcom (formerly plx technology) vendor prefix
      ARM: tegra: apalis_t30: drop module level model and compatible
      ARM: tegra: apalis_t30: drop obsolete spidev nodes
      ARM: tegra: apalis_t30: hog group for pcie switch reset gpio
      ARM: tegra: apalis_t30: rename hdmiddc to hdmi_ddc
      ARM: tegra: apalis_t30: rename tps65911 at 2d, stmpe811 at 41 and tps62362 at 60
      ARM: tegra: apalis_t30: fix mcp2515 can controller interrupt polarity
      ARM: tegra: apalis_t30: move hda node from carrier to module
      ARM: tegra: apalis_t30: support v1.1 hardware revision
      ARM: tegra: colibri_t30: add local-mac-address property
      ARM: tegra: colibri_t30: reorder host1x/hdmi properties
      ARM: tegra: colibri_t30: regulator clean-up
      ARM: tegra: colibri_t30: add missing regulators
      ARM: tegra: colibri_t30: annotate uarts and move compatible to board
      ARM: tegra: colibri_t30: white-space clean-up
      ARM: tegra: colibri_t30: move dr_mode property from phy to controller
      ARM: tegra: colibri_t30: reorder backlight properties
      ARM: tegra: colibri_t30: drop pwmleds
      ARM: tegra: colibri_t30: pinmux clean-up
      ARM: tegra: colibri_t30: add missing pinmux
      ARM: tegra: colibri_t30: use proper irq-gpio for stmpe811
      ARM: tegra: colibri_t30: further lm95245 temperature sensor annotation
      ARM: tegra: colibri_t30: add i2c-thermtrip
      ARM: tegra: colibri_t30: add proper emmc vmmc and vqmmc supplies
      ARM: tegra: colibri_t30: enable emmc ddr52 mode
      ARM: tegra: colibri_t30: get rid of fake clocks simple bus
      ARM: tegra: colibri_t30: line break long compatible property line
      ARM: tegra: colibri_t30: move input include to carrier board
      ARM: tegra: colibri_t30: remove unused nvidia, is-wired property
      ARM: tegra: colibri_t30: add gpio hog to unreset usb ethernet chip
      ARM: tegra: colibri_t30: enable hda over hdmi
      ARM: tegra: colibri_t30: annotate sd card detect
      ARM: tegra: colibri_t30: annotate ehci instance 1
      ARM: tegra: colibri_t30: update compatibility comment
      ARM: tegra: colibri_t30: drop module level model and compatible
      ARM: tegra: colibri_t30: drop obsolete spidev node
      ARM: tegra: colibri_t30: rename hdmiddc to hdmi_ddc
      ARM: tegra: colibri_t30: rename tps65911 at 2d, stmpe811 at 41 and tps62362 at 60
      ARM: tegra: colibri_t30: fix mcp2515 can controller interrupt polarity
      ARM: tegra: colibri_t30: remove unused mcp2515 can0 label
      ARM: tegra: colibri_t30: add mcp2515 vdd and xceiver supplies
      ARM: tegra: colibri_t30: annotate unused i2c busses
      ARM: tegra: colibri_t30: annotate power I2C being on-module
      ARM: tegra: apalis-tk1: add local-mac-address property
      ARM: tegra: apalis-tk1: reorder host1x/hdmi properties
      ARM: tegra: apalis-tk1: reorder padctl properties
      ARM: tegra: apalis-tk1: regulator clean-up
      ARM: tegra: apalis-tk1: add missing regulators
      ARM: tegra: apalis-tk1: drop unused pinmux label
      ARM: tegra: apalis-tk1: white-space clean-up
      ARM: tegra: apalis-tk1: reorder backlight properties
      ARM: tegra: apalis-tk1: add proper emmc vmmc and vqmmc supplies
      ARM: tegra: apalis-tk1: enable emmc ddr52 mode
      ARM: tegra: apalis-tk1: add toradex, apalis-tk1-v1.2 compatible
      ARM: tegra: apalis-tk1: reorder cpu dfll clock properties
      ARM: tegra: apalis-tk1: reorder SD card properties
      ARM: tegra: apalis-tk1: drop module level model and compatible
      ARM: tegra: apalis-tk1: drop obsolete spidev nodes
      ARM: tegra: apalis-tk1: replace underscores in node names with dashes
      ARM: tegra: apalis-tk1: get rid of fake clocks simple bus
      ARM: tegra: apalis-tk1: shorten temperature-sensor node
      ARM: tegra: apalis-tk1: drop unused hdmi_ddc label
      ARM: tegra: colibri_t20: move aliases from module to carrier board
      ARM: tegra: colibri_t20: iris: integrate i2c real time clock support
      ARM: tegra: colibri_t20: iris: add missing aliases
      ARM: tegra: colibri_t20: iris: annotate i2c busses
      ARM: tegra: colibri_t20: add local-mac-address property
      ARM: tegra: colibri_t20: reorder host1x/hdmi properties
      ARM: tegra: colibri_t20: iris: use no-1-8-v
      ARM: tegra: colibri_t20: regulator clean-up
      ARM: tegra: colibri_t20: add missing regulators
      ARM: tegra: colibri_t20: annotate usb ehci instances
      ARM: tegra: colibri_t20: remove phy-reset-gpio from controller node
      ARM: tegra: colibri_t20: indentation/line-feed/white-space clean-up
      ARM: tegra: colibri_t20: update sound nvidia,model
      ARM: tegra: colibri_t20: pinmux clean-up
      ARM: tegra: colibri_t20: add missing pinmux
      ARM: tegra: colibri_t20: iris: display controller rgb panel support
      ARM: tegra: colibri_t20: iris: annotate uarts
      ARM: tegra: colibri_t20: iris: add uart-c
      ARM: tegra: colibri_t20: use high speed uart driver
      ARM: tegra: colibri_t20: iris: add gpio wakeup key
      ARM: tegra: colibri_t20: iris: add dr_mode property
      ARM: tegra: colibri_t20: annotate/rename lm95245 temperature sensor
      ARM: tegra: colibri_t20: add i2c-thermtrip
      ARM: tegra: colibri_t20: add gpio hog to unreset usb ethernet chip
      ARM: tegra: colibri_t20: add gpio hogs for gmi_wr_n buffers
      ARM: tegra: colibri_t20: annotate/move sd card detect
      ARM: tegra: colibri_t20: add compatibility comment
      ARM: tegra: colibri_t20: simplify model and compatible properties
      ARM: tegra: colibri_t20: iris: simplify model and compatible properties
      ARM: tegra: colibri_t20: iris: add colibri ssp support
      ARM: tegra: colibri_t20: drop module level model and compatible
      ARM: tegra: colibri_t20: rename i2c_ddc to hdmi_ddc
      ARM: tegra: colibri_t20: iris: drop unused i2c_ddc label
      ARM: tegra: colibri_t20: rename tps6586x at 34 and drop unused pmic label
      ARM: tegra: colibri_t20: get rid of fake clocks simple bus
      ARM: tegra: colibri_t20: rename ac97 label to tegra_ac97
      ARM: tegra: colibri_t20: add eval board device tree

 Documentation/devicetree/bindings/arm/tegra.txt    |    9 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/tegra124-apalis-eval.dts         |   40 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts    |   43 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi        |  452 ++++----
 arch/arm/boot/dts/tegra124-apalis.dtsi             |  451 ++++----
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts      |  262 +++++
 arch/arm/boot/dts/tegra20-colibri-iris.dts         |  200 +++-
 arch/arm/boot/dts/tegra20-colibri.dtsi             |  657 +++++++----
 arch/arm/boot/dts/tegra20-paz00.dts                |   12 +-
 arch/arm/boot/dts/tegra20.dtsi                     |   28 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts          |  148 +--
 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts     |  266 +++++
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi         | 1189 ++++++++++++++++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi              |  705 +++++++++---
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |  130 +--
 arch/arm/boot/dts/tegra30-colibri.dtsi             |  780 ++++++++++---
 arch/arm/boot/dts/tegra30.dtsi                     |   10 +-
 19 files changed, 4173 insertions(+), 1212 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
