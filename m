From: olof@lixom.net (Olof Johansson)
Date: Mon,  9 Nov 2015 19:33:23 -0800
Subject: [GIT PULL 5/6] ARM: DT updates for v4.4
In-Reply-To: <1447126404-10567-1-git-send-email-olof@lixom.net>
References: <1447126404-10567-1-git-send-email-olof@lixom.net>
Message-ID: <1447126404-10567-6-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As usual, this is the massive branch we have for each release. Lots of
various updates and additions of hardware descriptions on existing hardware,
as well as the usual additions of new boards and SoCs.

This is also the first release where we've started mixing 64- and 32-bit
DT updates in one branch.

(Specific details on what's actually here and new is pretty easy to tell
from the diffstat, so there's little point in duplicating listing it here.)



Conflicts:

Add/add conflict in Documentation/devicetree/mfd, keep both sides.
Add/add conflict in sama5d2 dtsi too (with DTS contents picked up by
pinctrl), keep both sides but don't forget the '};' since git doesn't
duplicate it.

----------------------------------------------------------------

The following changes since commit e3686941e9b92673f7eee42754362d5579a47996:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 3e4dda70cc989a4f8079541972942609229e9f55:

  Merge branch 'next/arm64' into next/dt

----------------------------------------------------------------

Adam Sampson (3):
      ARM: dts: sun7i: Correct USB regulators on pcDuino v3 Nano
      ARM: dts: sun7i: Add regulator configuration for pcDuino v3 Nano
      ARM: dts: sun7i: Enable USB DRC on pcDuino v3 Nano

Adrian Alonso (2):
      ARM: dts: imx7d-pinfunc: add gpio1 pad iomux settings
      ARM: dts: imx: imx7d add iomuxc lpsr device node

Alan Tull (1):
      ARM: socfpga: dts: add fpga manager

Aleksei Mamlin (3):
      ARM: dts: sun4i: Enable USB DRC on the Marsboard A10
      ARM: dts: sun7i: Enable USB DRC on Wexler TAB7200
      ARM: dts: sun4i: Enable audio codec on Marsboard A10.

Alexandre Belloni (1):
      ARM: at91/dt: use syscon for PMC

Alexandru M Stan (2):
      ARM: dts: rockchip: pull up cts lines on rk3288
      ARM: dts: rockchip: Remove specific cts pullup from veyron

Alim Akhtar (1):
      arm64: dts: Add BUS1 instance pinctrl support for exynos7

Alison Wang (1):
      ARM: ls1021a: Add dma-coherent property for eTSEC nodes

Andy Gross (1):
      arm64: dts: qcom: Add 8x16 Serial UART1 node

Anson Huang (3):
      ARM: dts: imx6ul: add sram support for i.mx6ul
      ARM: dts: imx6ul: add mmdc support for i.mx6ul
      ARM: dts: imx6ul: add pm_power_off support

Antoine Tenart (6):
      ARM: berlin: dts: add the cpufreq-dt bindings on the BG2Q
      ARM: berlin: dts: add the cpufreq-dt bindings on the BG2
      ARM: berlin: dts: add the cpufreq-dt bindings on the BG2CD
      ARM: berlin: add a PWM node on the BG2Q
      ARM: berlin: add a PWM node on the BG2
      ARM: berlin: add a PWM node on the BG2CD

Ariel D'Alessandro (3):
      ARM: dts: lpc18xx: add watchdog node
      ARM: dts: lpc18xx: add sct pwm node
      ARM: dts: lpc4350-hitex-eval: add i2c0 and devices

Arnaud Ebalard (3):
      ARM: mvebu: add crypto related nodes to armada 370 dtsi
      arm: mvebu: disable unused Armada RTC on ReadyNAS 102, 104 and 2120
      arm: mvebu: reorder nodes under internal-regs by address in RN2120 .dts file

Arnd Bergmann (27):
      Merge tag 'hip05-dt-for-4.3' of git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'sti-dt-for-v4.4-1' of https://git.kernel.org/.../mcoquelin/sti into next/dt
      Merge tag 'at91-dt' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'xgene-dts-for-v4.4-1' of https://github.com/AppliedMicro/xgene-next into next/dt
      Merge tag 'socfpga_dts_for_v4.4' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge branch 'renesas/cleanup' into next/dt
      Merge tag 'renesas-dt-for-v4.4' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'keystone-dts' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'v4.4-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'arm-soc/for-4.4/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'mvebu-dt-4.4-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'berlin-dt-for-4.4-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt
      Merge tag 'berlin64-dt-for-4.4-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt
      Merge tag 'lpc18xx_dts_for_4.4' of https://github.com/manabian/linux-lpc into next/dt
      Merge tag 'sunxi-dt-for-4.4' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'hisi-soc-dt-for-4.4' of git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'samsung-dt-1' of git://git.kernel.org/.../kgene/linux-samsung into next/dt
      Merge tag 'renesas-dt2-for-v4.4' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'qcom-dt-for-4.4' of git://codeaurora.org/quic/kernel/agross-msm into next/dt
      Merge tag 'berlin-dt-cpuclk-for-4.4-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt
      Merge tag 'omap-for-v4.4/dt-pt1' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'keystone-dts-part2' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'juno-scpi-for-v4.4' of git://git.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'qcom-arm64-for-4.4' of git://codeaurora.org/quic/kernel/agross-msm into next/dt
      Merge tag 'sti-dt-for-v4.4-2' of https://git.kernel.org/.../mcoquelin/sti into next/dt
      Merge tag 'omap-for-v4.4/dt-pt2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'at91-ab-dt2' of git://git.kernel.org/.../abelloni/linux into next/dt

Baruch Siach (2):
      ARM: digicolor: add pinctrl module device node
      ARM: digicolor: dts: add uart pin configuration

Bhupesh Sharma (11):
      arm64: Use generic Layerscape SoC family naming
      arm64: Rename FSL LS2085A SoC support code to LS2080A
      Documentation: DT: Add entry for FSL LS2080A QDS and RDB boards
      Documentation/dts: Move FSL board-specific bindings out of /powerpc
      doc/bindings: Update GPIO devicetree binding documentation for LS2080A
      doc: DTS: Update DWC3 binding to provide reference to generic bindings
      dts/ls2080a: Update DTSI to add support of various peripherals
      dts/ls2080a: Remove text about writing to Free Software Foundation
      dts/ls2080a: Update Simulator DTS to add support of various peripherals
      dts/ls2080a: Add DTS support for LS2080a QDS & RDB boards
      dts/Makefile: Add build support for LS2080a QDS & RDB board DTS

Bjorn Andersson (2):
      soc: qcom: Add device tree binding for SMEM
      ARM: dts: msm8974: Add smd, rpm and regulator nodes

Bo Shen (1):
      ARM: at91/dt: at91sam9n12ek: disable i2c1

Boris Brezillon (9):
      ARM: mvebu: add crypto related nodes to armada-xp.dtsi
      ARM: mvebu: define crypto SRAM ranges for all armada-xp boards
      ARM: mvebu: define crypto SRAM ranges for all armada-370 boards
      ARM: mvebu: add crypto related nodes to armada 375 dtsi
      ARM: mvebu: define crypto SRAM ranges in armada-375-db.dts
      ARM: mvebu: add crypto related nodes to armada 38x dtsi
      ARM: mvebu: define crypto SRAM ranges for all armada-38x boards
      ARM: mvebu: use new bindings for existing crypto devices
      ARM: mvebu: modify Orion and Kirkwoord crypto compatible strings

Brian Norris (3):
      Documentation: dt: brcmstb: add system PM bindings
      ARM: dts: brcmstb: add BCM7445 system PM DT nodes
      ARM: dts: rockchip: add veyron-jaq board

Caesar Wang (1):
      ARM: dts: rockchip: add the support power-domain node on RK3288 SoCs

Carlo Caione (4):
      of: documentation: Add vendor prefix for Tronfy
      of: documentation: add bindings documentation for Meson8b
      ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards
      ARM: meson6: DTS: Fix wrong reg mapping and IRQ numbers

Chen-Yu Tsai (21):
      ARM: dts: sun6i: hummingbird: Add missing pinmux setting for gmac phy reset
      ARM: dts: sun6i: Add lradc node
      ARM: dts: sun6i: Add mmc2 pins for 8 bit emmc
      ARM: dts: sun8i: Add PWM controller node for A23/A33
      ARM: dts: sun8i: Add PWM channel 0 pinmux setting for A23/A33
      ARM: dts: sun8i: Add pwm-backlight device for A23/A33 Q8 format tablets
      ARM: dts: sun8i-a33: Add security system crypto engine clock and device nodes
      ARM: dts: sun6i: hummingbird: Add aliases for rtc devices
      ARM: dts: sun8i: Add Reduced Serial Bus controller device node to A23/A33 dtsi
      ARM: dts: sun8i: q8-common: Enable RSB controller for A23/A33 Q8 tablets
      ARM: dts: sun8i: sinlinx-sina33: Enable Reduced Serial Bus controller
      ARM: dts: sun6i: hummingbird: Drop AXP221 DC1SW and DC5LDO supplies
      ARM: dts: sunxi: Add dtsi for AXP22x PMIC
      ARM: dts: sunxi: Enable PWM controller on Q8 format tablets
      ARM: dts: sun6i: hummingbird: Fix VDD-CPU and VDD-GPU regulator names
      ARM: dts: sun6i: hummingbird: Use axp22x.dtsi for AXP221 regulators
      ARM: dts: sun6i: hummingbird: Enable AXP221 DC5LDO regulator as "vdd-cpus"
      ARM: dts: sun8i: Add NMI interrupt controller node
      ARM: dts: sun6i: Add support for Sinlinx A31s SDK board
      ARM: sun4i: Enable cubieboard audio codec
      ARM: dts: sun6i: Add simplefb node labels to reference at board level

Courtney Cavin (2):
      dt-binding: power: Add Qualcomm SMBB binding
      ARM: dts: qcom-pm8941: Add charger node

Ding Tianhong (2):
      arm64: hip05-d02: Document devicetree bindings for Hisilicon Hip05-D02 Board
      arm64: dts: add dts files for Hisilicon Hip05-D02 Development Board

Dinh Nguyen (3):
      ARM: socfpga: dts: add clock fields for I2C, UART and USB on Arria10
      ARM: socfpga: dts: enable USB and I2C on Arria10 SoCDK
      arm64: dts: Add base stratix 10 dtsi

Douglas Anderson (1):
      ARM: dts: rockchip: Add the hdmi-ddc pinctrl settings for rk3288

Duc Dang (4):
      MAINTAINERS: Add Applied Micro (APM) X-Gene Device Tree maintainer
      arm64: dts: Add X-Gene v2 reboot driver dts node
      arm64: dts: Add APM X-Gene 2 standby GPIO controller DTS entries
      arm64: dts: Add poweroff device nodes for APM X-Gene 2 platform

Emilio Lopez (1):
      ARM: dts: Enable EC vboot context support on Peach boards

Emilio L?pez (2):
      ARM: sun7i: Add sunxi codec device node
      ARM: sun7i: dt: enable audio codec on Cubietruck

Eric Anholt (3):
      Merge remote-tracking branch 'clk/clk-bcm2835' into bcm2835-dt-next
      ARM: bcm2835: Switch to using the new clock driver support.
      ARM: bcm2835: Add the DDC I2C controller to the device tree.

Fabio Estevam (4):
      ARM: dts: imx6sl: Complete the dcp node
      ARM: dts: imx7d: Add PWM support
      ARM: dts: imx7d: Add USB support
      ARM: dts: imx7d-sdb: Add USB support

Feng Kan (5):
      Documentation: arm64: add SCU dts binding documentation to linux kernel
      arm64: dts: Add X-Gene reboot driver dts node
      arm64: dts: add APM Merlin Board device tree
      Documentation: arm: pmu: Add Potenza PMU binding
      arm64: dts: Add PMU node for APM X-Gene Storm SOC

Florian Fainelli (1):
      Documentation: bindings: brcmstb: Document write-pairing

Franklin S Cooper Jr (1):
      ARM: dts: keystone: Add ti,keystone-spi for SPI

Fugang Duan (2):
      ARM: dts: imx7d: add fec1 and fec2 support for i.MX7d soc
      ARM: dts: imx7d-sdb: add fec1 and fec2 support

Gabriel Fernandez (2):
      ARM: DT: STi: STiH418: Fix mmc0 clock configuration
      ARM: STi: DT: Add support for stih418 A9 pll

Gary Bisson (11):
      ARM: dts: imx6qdl-nitrogen6x: add Okaya LCD panel
      ARM: dts: imx6qdl-sabrelite: add Okaya LCD panel
      ARM: dts: imx6dql-nitrogen6x: add touchscreen support
      ARM: dts: imx6qdl-nitrogen6x: add wifi wl1271 support
      ARM: dts: imx6qdl-nitrogen6x: relicense under GPLv2/X11
      ARM: dts: imx6qdl-sabrelite: relicense under GPLv2/X11
      of: Add Boundary Devices Inc. vendor prefix
      ARM: dts: imx6q-nitrogen6x: change manufacturer to Boundary Devices
      ARM: dts: imx6dl-nitrogen6x: change manufacturer to Boundary Devices
      ARM: dts: imx: add Boundary Devices Nitrogen6_Max board
      ARM: dts: imx: add Boundary Devices Nitrogen6_Lite board

Geert Uytterhoeven (1):
      ARM: shmobile: kzm9g dts: Use adxl345-specific compatible property

Georgi Djakov (1):
      arm64: dts: qcom: Enable eMMC on apq8016-sbc board

Gregory CLEMENT (1):
      ARM: at91/dt: sama5d4: add the macb1 node

Grygorii Strashko (3):
      ARM: dts: dra7-evm: add pcf8575 gpio expander (i2c1 addr 20)
      ARM: dts: dra7-evm: add gpio leds support
      ARM: dts: dra7-evm: add gpio key support

Haibo Chen (3):
      ARM: dts: imx7d-sdb: add eMMC5.0 support
      ARM: dts: imx6ul.dtsi: add TSC support
      ARM: dts: imx6ul-14x14-evk.dts: add tsc support

Hans de Goede (33):
      ARM: dts: sun4i: Enable otg in host only mode on Jesurun Q5
      ARM: dts: sun4i: Enable i2c1 and i2c2 on the Chuwi V7-CW0825 tablet
      ARM: dts: sun6i: Columbus: Add i2c controller for communicating with the LCD
      ARM: dts: sun5i: Add simplefb node for tvencoder output
      ARM: dts: sun8i: Add support for qt90h-v4 tablets
      ARM: dts: sun5i: Add support for the Auxtek-T003 HDMI stick
      ARM: dts: sun4i: inet97fv2: Disable unused usb controllers
      ARM: dts: sun4i: inet97fv2: Add regulator nodes
      ARM: dts: sun4i: inet97fv2: Enable otg controller
      ARM: dts: sun4i: inet97fv2: Enable support for tablet keys
      ARM: dts: sun4i: inet97fv2: Enable i2c1 and i2c2 controllers
      ARM: dts: sun5i: Add dts file for inet98v_rev2 based tablets
      ARM: dts: sunxi: Add sun?i-q8-common.dtsi files for q8 tablets
      ARM: dts: sun4i: Add dts file inet9f-rev03 based tablets
      ARM: dts: sun4i: Add dts file for iNet-1 based tablets
      ARM: dts: sun5i: Add sun5i-q8-common.dtsi
      ARM: dts: sun5i: Add dts file for q8 formfactor a13 based tablets
      ARM: dts: sun8i: Add sun8i-a33-q8-tablet.dts file
      ARM: dts: sun8i: Make ippo-q8h-v1.2.dts a symlink to q8-tablet.dts
      ARM: dts: axp209: Add usb_power_supply child node to the ax209 node
      ARM: dts: sun7i: Enable USB DRC on orangepi-mini
      ARM: dts: sun7i: Enable USB DRC on Bananapi
      ARM: dts: sun5i: Add PWM controller node for A13 / A10s
      ARM: dts: sun5i: Add PWM channel 0 pinmux setting for A13/A10s
      ARM: dts: sun5i: Add backlight node to sun5i-q8-common.dtsi
      ARM: dts: sun8i: Add sun8i-a23-q8-tablet.dts file
      ARM: dts: sun8i: Make ippo-q8h-v*.dts a symlink to q8-tablet.dts
      ARM: dts: sun8i: Make et-q8-v1.6.dts a symlink to q8-tablet.dts
      ARM: dts: sun6i: Turn on gmac on Colombus
      ARM: dts: sunxi: Fix interrupt-cells for [r]pio on A23/A31/A33/A80
      ARM: dts: sun6i: Add mmc2_pins_a pinmux setting to sun6i-a31.dtsi
      ARM: dts: sun6i: Add a dts file for the Sinovoip BPI-M2 board
      ARM: dts: sun4i: Add dts file for the pov protab2-ips9 tablet

Hauke Mehrtens (2):
      ARM: BCM5301X: add NAND flash chip description for Asus RT-AC87U
      ARM: BCM5301X: Netgear R6250 add USB GPIO

Heiko Stuebner (6):
      ARM: dts: rockchip: add rk3288-popmetal board to dtb list
      ARM: dts: rockchip: add rk3288-popmetal mmc supplies
      ARM: dts: rockchip: add rk3288-popmetal iodomains
      ARM: dts: rockchip: fixup firefly mmc supplies
      ARM: dts: rockchip: add rk3288-firefly iodomains
      Merge branch 'v4.4-armsoc/pd-headers' into v4.4-armsoc/dts32

Holger Busse (1):
      ARM: at91/dt: corrections to i2c1 declaration to sama5d4

Horia Geant? (1):
      ARM: dts: ls1021a: add crypto node

Ian Campbell (1):
      ARM64: dts: vexpress: Use a symlink to vexpress-v2m-rs1.dtsi from arch=arm

Jaehoon Chung (1):
      ARM: dts: use exynos5420-dw-mshc compatible for exynos3250

James Liao (3):
      dt-bindings: soc: Add clocks for Mediatek SCPSYS unit
      arm64: dts: mt8173: Add subsystem clock controller device nodes
      arm64: dts: mt8173: Add clocks for SCPSYS unit

Javier Martinez Canillas (14):
      ARM: dts: mt8135-evbp1: remove regulator-compatible usage
      ARM: dts: Add Exynos5250 Snow Rev5+ support on exynos5250-snow-rev5
      ARM: dts: Remove regulator-compatible usage in exynos4412-trats2
      ARM: dts: Use GPIO constants for flags cells in exynos3250 boards
      ARM: dts: Use GPIO constants for flags cells in exynos4120 boards
      ARM: dts: Use GPIO constants for flags cells in exynos4412 boards
      ARM: dts: Use GPIO constants for flags cells in exynos5420/5422/5800 boards
      ARM: dts: Use GPIO constants for flags cells in exynos5440 boards
      ARM: dts: Use defined GPIO constants in flags cell for OMAP2+ boards
      ARM: dts: omap3-lilly-a83x: Don't use IRQ level flag for a GPIO
      ARM: dts: Update Javier Martinez Canillas's email
      ARM: dts: omap3-igep0020: Use IOPAD pinmux macro
      ARM: dts: am335x-igep0033: Use IOPAD pinmux macro
      ARM: dts: am335x-base0033: Use IOPAD pinmux macro

Jelle de Jong (1):
      ARM: dts: sun7i: Add dts file for Wits Pro A20 DKT

Jelle van der Waa (4):
      ARM: dts: sun7i: Add regulator configuration to the pcduino3 dts file
      ARM: dts: sun7i: Enable USB DRC on pcDuino 3
      ARM: dts: sun5i: Add emac_pins_b definition
      ARM: dts: sun5i: Add dts file for the Wobo i5 top set box

Jisheng Zhang (4):
      arm: dts: berlin: add aliases for serial
      arm: dts: berlin: use stdout-path
      arm64: dts: berlin4ct: add GPIO nodes
      arm64: dts: add dts file for Marvell Berlin4CT STB board

Joachim Eastwood (13):
      ARM: dts: lpc18xx: add rgu node
      ARM: dts: lpc18xx: add spifi node
      ARM: dts: lpc18xx: add dmac node
      ARM: dts: lpc18xx: add dmamux node
      ARM: dts: lpc18xx: add dma to ssp0/1
      ARM: dts: lpc18xx: add dma to uart0/1/2/3
      ARM: dts: lpc18xx: add i2c nodes
      ARM: dts: lpc18xx: add resets entry to device nodes
      ARM: dts: lpc4357-ea4357: add spifi and flash device
      ARM: dts: lpc4357-ea4357: add ssp0
      ARM: dts: lpc4357-ea4357: add i2c0 and devices
      ARM: dts: lpc4350-hitex-eval: add spifi and flash device
      ARM: dts: lpc4350-hitex-eval: add joystick, buttons and leds

Jon Hunter (1):
      ARM: tegra: Enable CPUFreq support for Tegra124 Chromebooks

Jon Mason (2):
      dt-bindings: Create Documentation for NSP DT bindings
      ARM: NSP: add minimal Northstar Plus device tree

Josh Wu (6):
      ARM: at91/dt: at91sam9n12ek: fix the led labels name
      ARM: at91/dt: at91sam9x5: enable iio touchscreen for 9x5ek
      ARM: at91/dt: sama5d3: update iio config for touchscreen
      ARM: at91/dt: sama5d4: add pioD pin mux mask and enable pioD
      ARM: at91/dt: sama5d4 xplained: enable the led D8
      ARM: at91/dt: ov2640: add hsync/vsync-active property

Kamil Debski (1):
      ARM: dts: Add pwm-fan node for exynos4412-odroidu3

Karsten Merker (1):
      ARM: dts: sun6i: Add dts file for MSI Primo81 tablet

Krzysztof Kozlowski (8):
      dt-bindings: Document grounded ACOKB pin on S2MPS11
      ARM: dts: Fix power off method for exynos5422-odroidxu3-common
      ARM: dts: Split audio configuration to separate exynos5422-odroidxu3-audio
      ARM: dts: Add support Odroid XU4 board for exynos5422-odroidxu4
      dt-bindings: Correct the example for Exynos power domain clocks
      dt-bindings: Consolidate Exynos SoC bindings
      dt-bindings: EXYNOS: Document compatibles from other vendors
      MAINTAINERS: Add documentation and dt-bindings for exynos stuff

Kukjin Kim (1):
      Merge tag 'samsung-dt-4.4-2' of http://github.com/krzk/linux into v4.4-next/dt-samsung

Kuninori Morimoto (6):
      ARM: shmobile: koelsch: use CCF for audio clock
      ARM: shmobile: lager: use CCF for audio clock
      ARM: shmobile: r8a7790: tidyup SSI resource region
      ARM: shmobile: r8a7791: tidyup SSI resource region
      ARM: shmobile: r8a7778: tidyup SSI resource region
      ARM: shmobile: dts: Add common file for AA121TD01 panel

Laurent Pinchart (6):
      ARM: dts: omap3-igep: Fix indentation
      ARM: dts: omap3-igep0020: Remove duplicate uart2 pinmux
      ARM: dts: omap3-igep: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: imx6sx-sdb: Fix typo in regulator enable GPIO property
      ARM: dts: Fix typo in regulator enable GPIO property in s5pv210-aquila
      ARM: dts: Fix typo in regulator enable GPIO property in s5pv210-goni

Lawrence Yu (1):
      ARM: dts: sun6i: Add support for Yones Toptech bs1078v2 tablets

Lee Jones (2):
      ARM: STi: DT: STiH407: Rename incorrect interrupt related binding
      ARM: STi: STiH407: Enable the 2 HW Random Number Generators for STiH4{07, 10}

Leilk Liu (1):
      arm64: dts: Add spi bus dts

Linus Walleij (2):
      ARM64: juno: add NOR flash to device tree
      ARM64: juno: disable NOR flash node by default

Liviu Dudau (3):
      Documentation: of: Document the bindings used by Juno R1 PCIe host bridge
      arm64: Juno: Add support for the PCIe host bridge on Juno R1
      arm64: defconfig: Enable PCI generic host bridge by default

Lubomir Rintel (3):
      ARM: bcm2835: dt: Raspberry Pi Model B had no I2S
      ARM: bcm2835: dt: Add Raspberry Pi Model B rev2
      ARM: bcm2835: dt: Add Raspberry Pi Model A+

Ludovic Desroches (3):
      ARM: at91/dt: add sama5d2 pinmux
      ARM: at91/dt: sama5d2 Xplained: add device pin muxing
      ARM: at91/dt: sama5d2: add missing devices

Lukasz Majewski (2):
      dt-bindings: Documentation entry to explain how to use PWM FAN as a cooling device
      ARM: dts: use pwm-fan device as a cooling device for exynos4412-odroidu3

Magnus Damm (1):
      ARM: shmobile: marzen: Board specific serial port order

Marcel Ziswiler (21):
      ARM: tegra: Whitespace clean-up for Tegra20/30/124
      ARM: tegra: apalis: Update hardware revisions compatibility comment
      ARM: tegra: apalis: Fix HDMI power supplies
      ARM: tegra: apalis: Fix pin muxing
      ARM: tegra: apalis: Add comment concerning eMMC
      ARM: tegra: apalis: Add digital audio pin muxing
      ARM: tegra: apalis-eval: Enable HDA controller
      ARM: tegra: apalis-eval: Set OTG dr_mode
      ARM: tegra: apalis-eval: Fix backlight PWM comment
      ARM: tegra: apalis-eval: Fix power/wakeup key
      ARM: tegra: colibri: Update hardware revisions compatibility
      ARM: tegra: colibri: Fix HDMI supplies
      ARM: tegra: colibri: Improve comment about thermal alert pin
      ARM: tegra: colibri: Add pin muxing for on-module power I2C
      ARM: tegra: colibri: Fix comment about 3v3 fixed supply
      ARM: tegra: colibri: Add touch pen interrupt pin muxing
      ARM: tegra: colibri: Activate STMPE811 touch controller
      ARM: tegra: colibri: Replace eMMC label by comment
      ARM: tegra: colibri-eval: Fix vendor string of M41T0M6 RTC
      ARM: tegra: colibri-eval: Add comment concerning SD/MMC
      ARM: tegra: colibri-eval: Fix power/wakeup key

Marcin Wojtas (1):
      ARM: mvebu: set SW polling as SDHCI card detection on A388-GP

Marcus Cooper (3):
      ARM: sun7i: dt: Add new Olimex A20 EVB device
      ARM: sun4i: Add sunxi codec device node
      ARM: sun4i: Enable audio-codec on Mele A1000

Marek Szyprowski (1):
      ARM: dts: Add vbus regulator to USB2 phy nodes on exynos3250, exynos4210 and exynos4412 boards

Masahiro Yamada (7):
      ARM: dts: uniphier: change the external bus address mapping
      ARM: dts: uniphier: use stdout-path instead of console
      ARM: dts: uniphier: add ProXstream2 Gentil board support
      ARM: dts: uniphier: add ProXstream2 Vodka board support
      ARM: dts: uniphier: add I2C aliases for ProXstream2 boards
      ARM: dts: uniphier: add outer cache controller nodes
      ARM: dts: uniphier: add system-bus-controller nodes

Maxime Coquelin (7):
      ARM: dts: stih407: Enable PWM nodes only board level
      ARM: dts: stih407/410: Tidy up display nodes
      ARM: dts: stih410: Enable USB2.0 and related PHY nodes at board level
      ARM: dts: Fix RGMII pinctrl timings
      ARM: dts: Add Ethernet node to STiH407 family
      ARM: dts: Enable Ethernet on STi's B2120 boards
      ARM: dts: Enable Ethernet on STi's B2199 board

Maxime Ripard (16):
      ARM: sun8i: Add the A33 AHB1 gates clock driver
      ARM: sun8i: Move A23 AHB1 gates out of common DTSI
      ARM: sun8i: A23: Add missing msgbox gate
      ARM: sun5i: Add R8 DTSI
      ARM: sun5i: dt: Move uart3 pinctrl node to common DTSI
      ARM: sun5i: dt: Add UART3 CTS and RTS pins
      ARM: sun5i: Add C.H.I.P DTS
      ARM: sun4i: Add audio PLL
      ARM: sun5i: Add audio PLL
      ARM: sun7i: Add audio PLL
      ARM: sun4i: Add audio codec clock
      ARM: sun5i: Add audio codec clock
      ARM: sun7i: Add audio codec clock
      ARM: sun5i: Add the Audio codec DT node
      ARM: sun7i: Enable cubieboard2 audio codec
      ARM: sun5i: chip: Enable the audio codec

Michael Opdenacker (3):
      ARM: dts: msm8974: fix typo in "disabled" property
      ARM: dts: imx6: phyFLEX: fix typo in "pinctrl-names"
      ARM: at91/dt: fix "disabled" property on at91rm9200

Mugunthan V N (4):
      ARM: dts: am335x: fix cd-gpios definition as per hardware design and dt binding docs
      ARM: dts: am43xx: fix cd-gpios definition as per hardware design and dt binding docs
      ARM: dts: dra7xx: am57xx: fix cd-gpios definition as per hardware design and dt binding docs
      ARM: dts: dra72-evm: remove cpsw gpio hogging and add mode-gpios

Murali Karicheri (1):
      ARM: dts: keystone: enable accumulator channels

Nicolas Ferre (2):
      ARM: at91/dt: sama5d3 xplained: disable pmic
      ARM: at91/dt: sama5d4: enable crypto nodes

Nishanth Menon (4):
      Documentation: dt: keystone: provide SoC specific compatible flags
      ARM: keystone: Update compatible to have SoC specific matches
      ARM: dts: keystone: Update SoC specific compatible flags
      Documentation: dt: keystone: Fix up missing quotes

Olliver Schinagl (6):
      ARM: dts: sunxi: enable otg port on the sun7i-a20-olinuxino-lime2
      dts: sunxi: add eeprom to A10 OLinuXino Lime board
      dts: sunxi: correct vendor prefix on OLinuXino a10s micro
      dts: sunxi: add eeprom to A20 OLinuXino Lime board
      dts: sunxi: add eeprom to A20 OLinuXino Lime2 board
      dts: sunxi: add eeprom to A20 OLinuXino micro board

Olof Johansson (16):
      Merge tag 'socfpga_dts_for_v4.4_part_2' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'socfpga_for_v4.4_cleanup' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'mvebu-dt-4.4-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'sunxi-dt-for-4.4-2' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'v4.4-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.3-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'v4.3-next-arm64' of https://github.com/mbgg/linux-mediatek into next/arm64
      Merge tag 'imx-dt-4.4' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'tegra-for-4.4-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'samsung-dt-2' of git://git.kernel.org/.../kgene/linux-samsung into next/dt
      Merge tag 'samsung-dt64' of git://git.kernel.org/.../kgene/linux-samsung into next/arm64
      Merge tag 'arm/soc/for-4.4/rpi-dt-v2' of https://github.com/Broadcom/stblinux into next/dt
      Merge tag 'sunxi-clocks-for-4.4' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'sunxi-dt-for-4.4-3' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge branch 'for-upstream/juno-pcie' of git://linux-arm.org/linux-ld into next/arm64
      Merge branch 'next/arm64' into next/dt

Patrice Vilchez (1):
      ARM: at91/dt: sama5d4ek: Add support of QT1070 and Maxtouch

Peter Griffin (11):
      ARM: STi: DT: STiH407: Add a cec0 pin definition
      ARM: STi: DT: STiH407: Add i2c3 alternate pin configs
      ARM: DT: STiH407: Add SPI 3 wire and 4 wire pinctrl configs
      ARM: DT: STiH407: Add serial3 pinctrl configuration
      ARM: DT: STiH407: Add SPI FSM (NOR Flash) Controller pin config
      ARM: DT: STiH407: Add NAND flash controller pin configuration
      ARM: DT: STiH407: Add systrace pin configuration
      ARM: DT: STiH407: Add SD pinctrl config for mmc0 controller
      ARM: DT: STiH407: Add pinconfig for IRB UHF and IRB TX
      ARM: DT: STiH407: Add RMII pinctrl support
      ARM: STi: STiH407: Add spi default pinctrl groups.

Peter Ujfalusi (10):
      ARM: dts: dra7: Add McASP3 node
      ARM: dts: dra7-evm: Rename mmc2_3v3 supply to evm_3v3_sw
      ARM: dts: dra7-evm: Add fixed regulator to be used by aic3106's DVDD
      ARM: dts: dra7-evm: Enable pcf8575 (0x26 address) on i2c2 bus
      ARM: dts: dra7-evm: Audio support
      ARM: dts: dra72-evm: Add fixed regulator representing DVDD supply for aic3106
      ARM: dts: dra72-evm: Add gpio hog for vin6_sel_s0 to select audio
      ARM: dts: dra72-evm: Audio support
      ARM: dts: am57xx-beagle-x15: Add fixed regulator for aic3104's DVDD
      ARM: dts: am57xx-beagle-x15: Enable analog audio support

Priit Laes (1):
      ARM: dts: sun4i: gemei-g9: Add accelerometer (bma250) IRQ

Punit Agrawal (1):
      arm64: dts: Add sensor node to Juno dt

Rafa? Mi?ecki (2):
      ARM: BCM5301X: Add DT for Netgear R7000
      ARM: dts: imx: add "jedec,spi-nor" flash compatible binding

Rajendra Nayak (1):
      arm: dts: qcom: Add #power-domain-cells property

Rajesh Bhagat (1):
      ARM: dts: ls1021a: Add quirk for Erratum A009116

Ralph Benadski (1):
      ARM: dts: sun7i: Enable USB DRC on cubieboard2

Ray Jui (10):
      ARM: dts: consolidate aliases for Cygnus dt files
      ARM: dts: Use label for device nodes in Cygnus dts
      ARM: dts: Put Cygnus core components under core bus
      ARM: dts: Move all Cygnus peripherals into axi bus
      ARM: dts: Reorder Cygnus peripherals
      ARM: dts: Enable various peripherals on bcm958305k
      ARM: dts: Enable NAND support on bcm911360_entphn
      ARM: dts: enable touchscreen support on Cygnus
      ARM: dts: fix Cygnus nand device node
      ARM: dts: move aliases back to .dts in Cygnus

Reinder de Haan (1):
      ARM: dts: sun7i: Enable USB DRC on the Orange pi

Robert Baldyga (1):
      ARM: dts: Add DMA support for serial ports in exynos4

Robert Nelson (1):
      ARM: dts: Add am335x-bonegreen

Roger Quadros (1):
      ARM: dts: am437x-gp-evm: Add DCAN sleep pins

Romain Perier (1):
      ARM: dts: rockchip: Add support for SD/MMC on MarsBoard-RK3066

Sanchayan Maity (1):
      ARM: dts: vf500-colibri: Add device tree node for touchscreen support

Sander Vermin (1):
      ARM: dts: sun6i: Add accelerometer on Columbus A31

Sean Paul (1):
      ARM: dts: Move display-timings node from fimd to dp in exynos5250-arndale, smdk5250 and smdk5420

Sergei Shtylyov (25):
      ARM: shmobile: r8a7794: add GPIO clocks
      ARM: shmobile: r8a7794: add GPIO DT support
      ARM: shmobile: r8a7794: add QSPI DT support
      ARM: shmobile: silk: add QSPI DT support
      ARM: shmobile: r8a7794: add I2C DT support
      ARM: shmobile: silk: add I2C1 DT support
      ARM: shmobile: r8a7794: add VIN DT support
      ARM: shmobile: silk: add VIN0/ADV7180 DT support
      ARM: shmobile: r8a7794: add internal PCI bridge nodes
      ARM: shmobile: silk: enable internal PCI
      ARM: shmobile: add Porter board DT bindings
      ARM: shmobile: porter: initial device tree
      ARM: shmobile: r8a7794: add USB PHY DT support
      ARM: shmobile: silk: enable USB PHY
      ARM: shmobile: r8a7794: link PCI USB devices to USB PHY
      ARM: shmobile: r8a7794: add HS-USB DT support
      ARM: shmobile: fix SILK board name
      ARM: shmobile: porter: add Ether DT support
      ARM: shmobile: porter: add SDHI0/2 DT support
      ARM: shmobile: porter: enable SATA0
      ARM: shmobile: porter: add I2C2 DT support
      ARM: shmobile: porter: add VIN0/ADV7180 DT support
      ARM: shmobile: porter: add QSPI DT support
      ARM: shmobile: porter: enable PCIe
      ARM: shmobile: porter: enable internal PCI and USB PHY

Shawn Guo (1):
      Merge tag 'imx-clk-4.4' into imx/dt

Shawn Lin (2):
      ARM: dts: rockchip: support highspeed sd-cards for rk3188-radxarock
      ARM: dts: rockchip: support highspeed sd-cards on rk3066a boards

Shengjiu Wang (1):
      ARM: dts: imx6: change the core clock of spdif

Siarhei Siamashka (4):
      ARM: dts: sun4i: Add AXP209 PMU regulators for pcDuino1/2
      ARM: dts: sun4i: Allow to use the PH6 pin for GPIO on pcDuino1/2
      ARM: sun4i: dt: Add new LinkSprite pcDuino2 board
      ARM: dts: sun4i: Enable USB DRC on pcDuino1/2

Simon Guinot (1):
      ARM: mvebu: add DT support for Seagate Personal Cloud

Simon Horman (1):
      ARM: shmobile: Add silk device tree bindings documentation

Sjoerd Simons (5):
      ARM: dts: rockchip: Add dtb for the Radxa Rock 2 Square board
      ARM: dts: rockchip: Add SPDIF transceiver for RK3188
      ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock
      ARM: dts: rockchip: Add SPDIF transceiver for RK3288
      ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock2 Square

Srinivas Kandagatla (17):
      ARM: dts: apq8064: remove redundant i2c pinctrl properties
      ARM: dts: ifc6410: remove unnecessary eeprom label
      ARM: dts: qs600: remove unnecessary eeprom label
      ARM: dts: apq8064: add pm8921 rtc
      ARM: dts: apq8064: add pm8921 pwrkey support
      ARM: dts: apq8064: Prefix the gsbi6 uart pins correctly
      ARM: dts: apq8064: add missing gsbi7 uart pinctrl
      ARM: dts: ifc6410: Add missing pinctrl to gsbi7 uart
      ARM: dts: qs600: Add missing pinctrl property for gsbi7 uart
      ARM: dts: ifc6410: Add pwrseq support for WLAN
      ARM: dts: qs600: add pwrseq support to WLAN
      ARM: dts: apq8064-ifc6410: add notify led support.
      ARM: dts: qs600: Add SD card detect support.
      arm64: dts: fix i2c pinconf sleep state function
      arm64: dts: qcom: Add msm8916 I2C nodes.
      arm64: dts: apq8016-sbc: enable i2c buses on LS and HS
      arm64: dts: apq8016-sbc: enable spi buses on LS and HS

Stanimir Varbanov (1):
      arm64: dts: qcom: Add RNG device tree node

Stefan Agner (2):
      ARM: dts: vf610twr: add NAND flash controller peripherial
      ARM: dts: vf-colibri: enable NAND flash controller

Stefan Wahren (2):
      ARM: bcm2835: add label for uart0
      ARM: mxs: enable ocotp for i.MX23 and i.MX28

Steffen Trumtrar (1):
      ARM: socfpga: dts: sort nodes alphabetically

Stephen Boyd (1):
      ARM: dts: qcom: Remove extra reg element from iadc device

Sudeep Holla (3):
      arm64: dts: add SRAM, MHU mailbox and SCPI support on Juno
      arm64: dts: add CPU topology on Juno
      arm64: dts: add clock support for all the cpus

Suman Anna (9):
      ARM: dts: DRA74x: Add IPC sub-mailbox nodes for all IPUs & DSPs
      ARM: dts: DRA72x: Add IPC sub-mailbox nodes for IPU1, IPU2 & DSP1
      ARM: dts: dra7-evm: Enable the system mailboxes 5 and 6
      ARM: dts: dra72-evm: Enable the system mailboxes 5 and 6
      ARM: dts: beagle-x15: Enable the system mailboxes 5 and 6
      ARM: dts: DRA7: Add dsp1_system syscon node
      ARM: dts: DRA74x: Add dsp2_system syscon node
      ARM: dts: DRA7: Add common IOMMU nodes
      ARM: dts: DRA74x: Add IOMMU nodes for DSP2

Sylvain Rochet (1):
      ARM: at91/dt: add pullup on mmc2 data signals

Tai Nguyen (1):
      power: reset: Add syscon poweroff device node for APM X-Gene platform

Teresa Remmet (1):
      ARM: dts: am335x-wega: Clean up regulators

Thierry Reding (3):
      ARM: tegra: apalis: Properly align pin names
      ARM: tegra: colibri: Properly align pin names
      ARM: tegra: Use consistent indentation for SATA node

Thomas Petazzoni (1):
      ARM: mvebu: add CPU config registers in the Armada 370/XP Device Tree

Timo Sigurdsson (1):
      ARM: dts: sunxi: Add regulators for LeMaker BananaPi

Tobias Jakobi (2):
      ARM: dts: Remove redundant pinctrl settings in exynos4412-odroid
      ARM: dts: Unify voltage regulator style in exynos4412-odroid

Tomeu Vizoso (2):
      clk: samsung: exynos5250: Add DISP1 clocks
      ARM: dts: Add clocks to DISP1 domain in exynos5250

Tony Lindgren (3):
      ARM: dts: Fix WLAN regression on omap5-uevm
      ARM: dts: Move most of omap5-uevm.dts to omap5-board-common.dtsi
      ARM: dts: Add basic support for isee igepv5

Tyler Baker (1):
      arm64: dts: add all hi6220 uart nodes

Vignesh R (1):
      ARM: dts: am437x-gp-evm: Add wakeup interrupt source for pixcir_i2c_ts

Vincent Donnefort (1):
      ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay

Vladimir Zapolskiy (5):
      ARM: dts: Fix cpu compatible value for s3c2416
      ARM: dts: i.MX31: fix cpu compatible value
      ARM: dts: i.MX35: fix cpu compatible value
      ARM: dts: TI-Nspire: fix cpu compatible value
      ARM: dts: WM8750: fix cpu compatible value

Wei Xu (1):
      ARM: hisilicon: DT: Drop console= and earlyprintk bootargs parameter

Wenyou Yang (1):
      ARM: at91/dt: sama5d2_xplained: add regulator nodes

Wolfram Sang (1):
      ARM: shmobile: r8a7790: lager: add pinmux for iic0

Yassin Jaffer (1):
      ARM: dts: sun7i: Add keypad clk node

Yingjoe Chen (5):
      arm64: mt8173.dtsi: correct i2c node names
      dt-bindings: add more MediaTek SoC to mtk-timer binding
      devicetree: bindings: add new SMP enable method Mediatek SoC
      ARM: dts: mt8135: enable basic SMP bringup for mt8135
      ARM: dts: mt8127: enable basic SMP bringup for mt8127

Yuan Yao (1):
      ARM: dts: Add node for ina220 on LS1021ATWR


 .../devicetree/bindings/arm/amlogic.txt         |  10 +-
 .../devicetree/bindings/arm/apm/scu.txt         |  17 +
 .../bindings/arm/bcm/brcm,brcmstb.txt           | 162 +++-
 .../devicetree/bindings/arm/bcm/brcm,nsp.txt    |  34 +
 Documentation/devicetree/bindings/arm/cpus.txt  |   2 +
 Documentation/devicetree/bindings/arm/fsl.txt   |  16 +-
 .../bindings/arm/hisilicon/hisilicon.txt        |   4 +
 .../bindings/arm/keystone/keystone.txt          |  20 +-
 Documentation/devicetree/bindings/arm/pmu.txt   |   1 +
 .../devicetree/bindings/arm/rockchip.txt        |  11 +
 .../devicetree/bindings/arm/samsung-boards.txt  |  27 -
 .../bindings/arm/samsung/samsung-boards.txt     |  69 ++
 .../devicetree/bindings/arm/shmobile.txt        |   4 +
 .../fsl/board.txt => board/fsl-board.txt}       |  14 +-
 .../devicetree/bindings/clock/qcom,gcc.txt      |   4 +
 .../devicetree/bindings/clock/qcom,mmcc.txt     |   4 +
 .../devicetree/bindings/gpio/gpio-mpc8xxx.txt   |   4 +-
 .../devicetree/bindings/hwmon/pwm-fan.txt       |  29 +-
 .../bindings/iommu/samsung,sysmmu.txt           |   2 +-
 .../devicetree/bindings/mfd/s2mps11.txt         |   4 +
 .../bindings/pci/arm,juno-r1-pcie.txt           |  10 +
 .../bindings/pci/plda,xpressrich3-axi.txt       |  12 +
 .../power_domain.txt => power/pd-samsung.txt}   |   5 +-
 .../devicetree/bindings/soc/mediatek/scpsys.txt |  10 +-
 .../devicetree/bindings/soc/qcom/qcom,smem.txt  |  57 ++
 .../bindings/timer/mediatek,mtk-timer.txt       |   8 +-
 Documentation/devicetree/bindings/usb/dwc3.txt  |   3 +-
 .../devicetree/bindings/vendor-prefixes.txt     |   3 +
 MAINTAINERS                                     |   9 +
 arch/arm/boot/dts/Makefile                      |  54 +-
 arch/arm/boot/dts/am335x-base0033.dts           |  48 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi       |   3 +-
 arch/arm/boot/dts/am335x-bonegreen.dts          |  53 ++
 arch/arm/boot/dts/am335x-evm.dts                |   2 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |   2 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi          |  40 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi       |  36 +-
 arch/arm/boot/dts/am335x-wega.dtsi              |  13 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |  31 +-
 arch/arm/boot/dts/am437x-idk-evm.dts            |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts             |   2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |   2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts         | 117 ++-
 arch/arm/boot/dts/armada-370-db.dts             |   3 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts  |   3 +-
 arch/arm/boot/dts/armada-370-mirabox.dts        |   7 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts  |   9 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts  |   9 +-
 arch/arm/boot/dts/armada-370-rd.dts             |   3 +-
 .../boot/dts/armada-370-seagate-nas-2bay.dts    |  36 +
 .../boot/dts/armada-370-seagate-nas-4bay.dts    | 133 +++
 .../boot/dts/armada-370-seagate-nas-xbay.dtsi   | 231 +++++
 .../armada-370-seagate-personal-cloud-2bay.dts  |  51 ++
 .../dts/armada-370-seagate-personal-cloud.dts   |  37 +
 .../dts/armada-370-seagate-personal-cloud.dtsi  | 178 ++++
 .../arm/boot/dts/armada-370-synology-ds213j.dts |   3 +-
 arch/arm/boot/dts/armada-370.dtsi               |  37 +
 arch/arm/boot/dts/armada-375-db.dts             |   4 +-
 arch/arm/boot/dts/armada-375.dtsi               |  33 +
 arch/arm/boot/dts/armada-385-db-ap.dts          |   4 +-
 arch/arm/boot/dts/armada-385-linksys.dtsi       |   4 +-
 arch/arm/boot/dts/armada-388-db.dts             |   4 +-
 arch/arm/boot/dts/armada-388-gp.dts             |  19 +-
 arch/arm/boot/dts/armada-388-rd.dts             |   4 +-
 arch/arm/boot/dts/armada-38x.dtsi               |  33 +
 arch/arm/boot/dts/armada-xp-axpwifiap.dts       |   4 +-
 arch/arm/boot/dts/armada-xp-db.dts              |   4 +-
 arch/arm/boot/dts/armada-xp-gp.dts              |   4 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts |   4 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts   |   4 +-
 arch/arm/boot/dts/armada-xp-matrix.dts          |   4 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts  |  90 +-
 .../arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   4 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts  |   4 +-
 arch/arm/boot/dts/armada-xp.dtsi                |  35 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     | 118 +++
 arch/arm/boot/dts/at91-sama5d3_xplained.dts     |   2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts     |   2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts            |  27 +
 arch/arm/boot/dts/at91rm9200.dtsi               |   8 +-
 arch/arm/boot/dts/at91sam9260.dtsi              |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi              |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi              |   2 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts          |   2 +
 arch/arm/boot/dts/at91sam9n12.dtsi              |   2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts             |   8 +-
 arch/arm/boot/dts/at91sam9rl.dtsi               |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi               |   5 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi             |   8 +
 arch/arm/boot/dts/axp209.dtsi                   |   5 +
 arch/arm/boot/dts/axp22x.dtsi                   | 143 +++
 arch/arm/boot/dts/bcm-cygnus.dtsi               | 334 +++----
 arch/arm/boot/dts/bcm-nsp.dtsi                  | 119 +++
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts        |  30 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts        |  23 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts             |   8 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |   4 +
 arch/arm/boot/dts/bcm2835.dtsi                  |  64 +-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |  11 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts     |   1 +
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts     | 106 +++
 arch/arm/boot/dts/bcm7445.dtsi                  |  84 ++
 arch/arm/boot/dts/bcm911360_entphn.dts          |  28 +-
 arch/arm/boot/dts/bcm911360k.dts                |   9 +-
 arch/arm/boot/dts/bcm958300k.dts                |  44 +-
 arch/arm/boot/dts/bcm958305k.dts                |  40 +-
 arch/arm/boot/dts/bcm958625k.dts                |  57 ++
 arch/arm/boot/dts/bcm9hmidc.dtsi                |  42 +
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts      |   3 +-
 arch/arm/boot/dts/berlin2.dtsi                  |  23 +
 .../boot/dts/berlin2cd-google-chromecast.dts    |   3 +-
 arch/arm/boot/dts/berlin2cd.dtsi                |  20 +
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts      |   3 +-
 arch/arm/boot/dts/berlin2q.dtsi                 |  23 +
 arch/arm/boot/dts/cx92755.dtsi                  |   7 +
 arch/arm/boot/dts/cx92755_equinox.dts           |   9 +
 arch/arm/boot/dts/dove.dtsi                     |  17 +-
 arch/arm/boot/dts/dra7-evm.dts                  | 222 ++++-
 arch/arm/boot/dts/dra7.dtsi                     |  60 ++
 arch/arm/boot/dts/dra72-evm.dts                 | 162 +++-
 arch/arm/boot/dts/dra72x.dtsi                   |  21 +
 arch/arm/boot/dts/dra74x.dtsi                   |  51 ++
 arch/arm/boot/dts/exynos3250-monk.dts           |   9 +-
 arch/arm/boot/dts/exynos3250-rinato.dts         |  11 +-
 arch/arm/boot/dts/exynos3250.dtsi               |   4 +-
 arch/arm/boot/dts/exynos4.dtsi                  |   8 +
 arch/arm/boot/dts/exynos4210-origen.dts         |  15 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |   3 +-
 arch/arm/boot/dts/exynos4210-trats.dts          |  31 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |  44 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  27 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |  45 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts        |   8 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |  15 +-
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |   9 +-
 arch/arm/boot/dts/exynos4412-trats2.dts         | 140 ++-
 arch/arm/boot/dts/exynos5250-arndale.dts        |   8 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |  16 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi   | 684 ++++++++++++++
 arch/arm/boot/dts/exynos5250-snow-rev5.dts      |  47 +
 arch/arm/boot/dts/exynos5250-snow.dts           | 671 +-------------
 arch/arm/boot/dts/exynos5250.dtsi               |   4 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |   3 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |   9 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |  14 +-
 .../boot/dts/exynos5422-odroidxu3-audio.dtsi    |  61 ++
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   | 102 +--
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts |  51 ++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      |  51 ++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts      |  48 +
 arch/arm/boot/dts/exynos5440-ssdk5440.dts       |   5 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |   9 +-
 arch/arm/boot/dts/hi3620-hi4511.dts             |   3 +-
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts            |   2 +-
 arch/arm/boot/dts/imx23.dtsi                    |   6 +-
 arch/arm/boot/dts/imx28-evk.dts                 |   2 +-
 arch/arm/boot/dts/imx28-m28evk.dts              |   2 +-
 arch/arm/boot/dts/imx28.dtsi                    |   6 +-
 arch/arm/boot/dts/imx31.dtsi                    |   2 +-
 arch/arm/boot/dts/imx35.dtsi                    |   2 +-
 arch/arm/boot/dts/imx50-evk.dts                 |   2 +-
 arch/arm/boot/dts/imx53-smd.dts                 |   2 +-
 arch/arm/boot/dts/imx6dl-nit6xlite.dts          |  49 ++
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts         |  44 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts          |   2 +-
 arch/arm/boot/dts/imx6dl-sabrelite.dts          |  40 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts         |   2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts            |   2 +-
 arch/arm/boot/dts/imx6q-nitrogen6_max.dts       |  53 ++
 arch/arm/boot/dts/imx6q-nitrogen6x.dts          |  44 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts             |   2 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts           |  40 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi     |   2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi    |   2 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi    |   2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi        | 630 +++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi    | 873 ++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi       | 189 +++-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi    |   6 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi        |   2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi        | 118 ++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                  |  12 +-
 arch/arm/boot/dts/imx6sl-evk.dts                |   2 +-
 arch/arm/boot/dts/imx6sl.dtsi                   |  21 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts           |   4 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                |   4 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi               |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                   |   2 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts          |  22 +
 arch/arm/boot/dts/imx6ul.dtsi                   |  29 +
 arch/arm/boot/dts/imx7d-pinfunc.h               | 122 ++-
 arch/arm/boot/dts/imx7d-sdb.dts                 | 100 ++-
 arch/arm/boot/dts/imx7d.dtsi                    | 165 ++++
 arch/arm/boot/dts/k2e-evm.dts                   |   2 +-
 arch/arm/boot/dts/k2e-netcp.dtsi                |  23 +
 arch/arm/boot/dts/k2e.dtsi                      |   3 +
 arch/arm/boot/dts/k2hk-evm.dts                  |   2 +-
 arch/arm/boot/dts/k2hk-netcp.dtsi               |  24 +
 arch/arm/boot/dts/k2hk.dtsi                     |   3 +
 arch/arm/boot/dts/k2l-evm.dts                   |   2 +-
 arch/arm/boot/dts/k2l-netcp.dtsi                |  23 +
 arch/arm/boot/dts/k2l.dtsi                      |   3 +
 arch/arm/boot/dts/keystone.dtsi                 |   7 +-
 arch/arm/boot/dts/kirkwood.dtsi                 |  29 +-
 arch/arm/boot/dts/lpc18xx.dtsi                  | 134 +++
 arch/arm/boot/dts/lpc4350-hitex-eval.dts        | 175 ++++
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts     |  95 ++
 arch/arm/boot/dts/ls1021a-twr.dts               |  13 +
 arch/arm/boot/dts/ls1021a.dtsi                  |  44 +
 arch/arm/boot/dts/meson8b-mxq.dts               |  67 ++
 arch/arm/boot/dts/meson8b-odroidc1.dts          |  67 ++
 arch/arm/boot/dts/meson8b.dtsi                  | 186 ++++
 arch/arm/boot/dts/mt8127.dtsi                   |  27 +
 arch/arm/boot/dts/mt8135-evbp1.dts              |  23 -
 arch/arm/boot/dts/mt8135.dtsi                   |  27 +
 arch/arm/boot/dts/nspire.dtsi                   |   2 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi     |   6 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts           |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts              |   2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi             |   2 +-
 .../boot/dts/omap3-devkit8000-lcd-common.dtsi   |   2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi         |   4 +-
 arch/arm/boot/dts/omap3-gta04.dtsi              |  10 +-
 arch/arm/boot/dts/omap3-gta04a5.dts             |   2 +-
 arch/arm/boot/dts/omap3-igep.dtsi               |  70 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi    |  60 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts      |   2 +-
 arch/arm/boot/dts/omap3-igep0020.dts            |  11 +-
 arch/arm/boot/dts/omap3-igep0030-common.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts      |   2 +-
 arch/arm/boot/dts/omap3-igep0030.dts            |   2 +-
 arch/arm/boot/dts/omap3-ldp.dts                 |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi         |   4 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts        |   4 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi         |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi     |   4 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi            |   4 +-
 arch/arm/boot/dts/omap3-zoom3.dts               |   2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi       |   4 +-
 arch/arm/boot/dts/omap4-sdp.dts                 |   6 +-
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi  |   2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi       |   2 +-
 arch/arm/boot/dts/omap4460.dtsi                 |   2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi       | 655 ++++++++++++++
 arch/arm/boot/dts/omap5-cm-t54.dts              |   2 +-
 arch/arm/boot/dts/omap5-igep0050.dts            |  54 ++
 arch/arm/boot/dts/omap5-uevm.dts                | 618 +------------
 arch/arm/boot/dts/orion5x.dtsi                  |  22 +-
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts     |  48 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts      |  60 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi             |  43 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi             |   1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi             |  78 +-
 arch/arm/boot/dts/qcom-pm8941.dtsi              |  24 +-
 arch/arm/boot/dts/r8a7778.dtsi                  |   2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts            |   6 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |  16 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |   2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |   9 +-
 arch/arm/boot/dts/r8a7791-porter.dts            | 282 ++++++
 arch/arm/boot/dts/r8a7791.dtsi                  |   2 +-
 arch/arm/boot/dts/r8a7794-silk.dts              | 114 +++
 arch/arm/boot/dts/r8a7794.dtsi                  | 326 ++++++-
 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi  |  41 +
 arch/arm/boot/dts/rk3066a-bqcurie2.dts          |   2 +
 arch/arm/boot/dts/rk3066a-marsboard.dts         |   8 +
 arch/arm/boot/dts/rk3066a-rayeager.dts          |   2 +
 arch/arm/boot/dts/rk3188-radxarock.dts          |  21 +
 arch/arm/boot/dts/rk3188.dtsi                   |  20 +
 arch/arm/boot/dts/rk3288-firefly.dtsi           |  55 +-
 arch/arm/boot/dts/rk3288-popmetal.dts           |  85 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         | 277 ++++++
 arch/arm/boot/dts/rk3288-rock2-square.dts       | 167 ++++
 arch/arm/boot/dts/rk3288-veyron-jaq.dts         | 176 ++++
 arch/arm/boot/dts/rk3288-veyron.dtsi            |  12 -
 arch/arm/boot/dts/rk3288.dtsi                   | 134 ++-
 arch/arm/boot/dts/s3c2416.dtsi                  |   2 +-
 arch/arm/boot/dts/s5pv210-aquila.dts            |   2 +-
 arch/arm/boot/dts/s5pv210-goni.dts              |   4 +-
 arch/arm/boot/dts/sama5d2-pinfunc.h             | 880 +++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi                  | 154 +++-
 arch/arm/boot/dts/sama5d3.dtsi                  |   5 +-
 arch/arm/boot/dts/sama5d3_mci2.dtsi             |   6 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi               |   2 +
 arch/arm/boot/dts/sama5d4.dtsi                  |  49 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts              |   2 +-
 arch/arm/boot/dts/socfpga.dtsi                  | 135 +--
 arch/arm/boot/dts/socfpga_arria10.dtsi          |   8 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi    |  27 +
 arch/arm/boot/dts/stih407-b2120.dts             |   1 +
 arch/arm/boot/dts/stih407-family.dtsi           |  74 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi          | 390 +++++++-
 arch/arm/boot/dts/stih407.dtsi                  |  13 -
 arch/arm/boot/dts/stih410-b2120.dts             |  25 +
 arch/arm/boot/dts/stih410.dtsi                  |  23 +-
 arch/arm/boot/dts/stih418-b2199.dts             |   8 +
 arch/arm/boot/dts/stih418-clock.dtsi            |   2 +-
 arch/arm/boot/dts/stih418.dtsi                  |   6 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi            |  14 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts           |   4 +
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts |  12 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      |   4 +
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts        |  11 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts           | 226 +++++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 117 ++-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts    | 227 +++++
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts      |  15 +
 arch/arm/boot/dts/sun4i-a10-marsboard.dts       |  23 +
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  |  12 +
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         |  58 +-
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts        |  78 ++
 .../arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts | 199 +++++
 arch/arm/boot/dts/sun4i-a10.dtsi                |  31 +
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts    | 159 ++++
 .../arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |   2 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts        | 224 +++++
 arch/arm/boot/dts/sun5i-a10s.dtsi               |  35 +-
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts   | 227 +++++
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts       |  60 ++
 arch/arm/boot/dts/sun5i-a13.dtsi                |  10 +
 arch/arm/boot/dts/sun5i-q8-common.dtsi          | 180 ++++
 arch/arm/boot/dts/sun5i-r8-chip.dts             | 218 +++++
 arch/arm/boot/dts/sun5i-r8.dtsi                 |  59 ++
 arch/arm/boot/dts/sun5i.dtsi                    |  52 ++
 arch/arm/boot/dts/sun6i-a31-colombus.dts        |  36 +
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts     | 132 +--
 arch/arm/boot/dts/sun6i-a31.dtsi                |  31 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts        | 255 ++++++
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi  | 140 +++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts        | 153 ++++
 .../arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 194 ++++
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts  | 134 +++
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        |  74 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |  23 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |   4 +
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts  | 198 +++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  |  12 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |  47 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   6 +
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts   |  29 +
 arch/arm/boot/dts/sun7i-a20-orangepi.dts        |  29 +
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts   |  65 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts        |  54 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts  |  33 +-
 .../arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts | 226 +++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  39 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |  70 +-
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts        | 145 +++
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts   |  55 +-
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts     | 137 +--
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts       |  65 ++
 arch/arm/boot/dts/sun8i-a23.dtsi                |  25 +
 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts      |  89 +-
 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts   | 134 +--
 arch/arm/boot/dts/sun8i-a33-q8-tablet.dts       |  65 ++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts  |   4 +
 arch/arm/boot/dts/sun8i-a33.dtsi                |  45 +
 arch/arm/boot/dts/sun8i-q8-common.dtsi          | 101 +++
 arch/arm/boot/dts/sun9i-a80.dtsi                |   2 +-
 arch/arm/boot/dts/sunxi-q8-common.dtsi          |  83 ++
 arch/arm/boot/dts/tegra124-nyan.dtsi            |  15 +-
 arch/arm/boot/dts/tegra124.dtsi                 |  20 +-
 arch/arm/boot/dts/tegra20.dtsi                  |   4 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts       |  13 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi           | 214 +++--
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts   |   9 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi          | 196 +++--
 arch/arm/boot/dts/tegra30.dtsi                  |  10 +-
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts      |   8 +-
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi         |  20 +-
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts     |   8 +-
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts     |   8 +-
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi        |  21 +-
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi        |  34 +-
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts     |   8 +-
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi        |  21 +-
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts     |   8 +-
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi        |  20 +-
 .../boot/dts/uniphier-proxstream2-gentil.dts    |  78 ++
 .../arm/boot/dts/uniphier-proxstream2-vodka.dts |  78 ++
 arch/arm/boot/dts/uniphier-proxstream2.dtsi     |  23 +-
 arch/arm/boot/dts/vf-colibri.dtsi               |  39 +
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts     |   5 +
 arch/arm/boot/dts/vf500-colibri.dtsi            |  47 +
 arch/arm/boot/dts/vf610-twr.dts                 |  47 +
 arch/arm/boot/dts/vfxxx.dtsi                    |  11 +
 arch/arm/boot/dts/wm8750.dtsi                   |   2 +-
 arch/arm/mach-keystone/keystone.c               |   3 +
 arch/arm64/Kconfig.platforms                    |  11 +-
 arch/arm64/boot/dts/Makefile                    |   1 +
 arch/arm64/boot/dts/altera/Makefile             |   5 +
 .../boot/dts/altera/socfpga_stratix10.dtsi      | 358 ++++++++
 .../boot/dts/altera/socfpga_stratix10_socdk.dts |  39 +
 arch/arm64/boot/dts/apm/Makefile                |   1 +
 arch/arm64/boot/dts/apm/apm-merlin.dts          |  72 ++
 arch/arm64/boot/dts/apm/apm-mustang.dts         |  12 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi      | 271 ++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi          |  17 +
 arch/arm64/boot/dts/arm/juno-base.dtsi          |  59 ++
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi   |  15 +
 arch/arm64/boot/dts/arm/juno-r1.dts             |  52 ++
 arch/arm64/boot/dts/arm/juno.dts                |  32 +
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts   |   2 +-
 arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi   |   1 +
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 103 +++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |   7 +
 arch/arm64/boot/dts/freescale/Makefile          |   4 +-
 .../boot/dts/freescale/fsl-ls2080a-qds.dts      | 204 +++++
 .../boot/dts/freescale/fsl-ls2080a-rdb.dts      | 166 ++++
 ...sl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} |  25 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi  | 515 +++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi  | 163 ----
 arch/arm64/boot/dts/hisilicon/Makefile          |   2 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts  |   7 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |  43 +-
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts     |  36 +
 arch/arm64/boot/dts/hisilicon/hip05.dtsi        | 271 ++++++
 arch/arm64/boot/dts/marvell/Makefile            |   1 +
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts   |  66 ++
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi      | 120 +++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts     |  18 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |  62 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |  30 +
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi      |  76 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |  47 +
 arch/arm64/configs/defconfig                    |   4 +-
 drivers/clk/samsung/clk-exynos5250.c            |  14 +-
 include/dt-bindings/clock/exynos5250.h          |   4 +-
 433 files changed, 20755 insertions(+), 3428 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/apm/scu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung-boards.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
 rename Documentation/devicetree/bindings/{powerpc/fsl/board.txt => board/fsl-board.txt} (90%)
 create mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt
 rename Documentation/devicetree/bindings/{arm/exynos/power_domain.txt => power/pd-samsung.txt} (93%)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smem.txt
 create mode 100644 arch/arm/boot/dts/am335x-bonegreen.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
 create mode 100644 arch/arm/boot/dts/axp22x.dtsi
 create mode 100644 arch/arm/boot/dts/bcm-nsp.dtsi
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
 create mode 100644 arch/arm/boot/dts/bcm4709-netgear-r7000.dts
 create mode 100644 arch/arm/boot/dts/bcm958625k.dts
 create mode 100644 arch/arm/boot/dts/bcm9hmidc.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5250-snow-common.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5250-snow-rev5.dts
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu4.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-nit6xlite.dts
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6_max.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
 create mode 100644 arch/arm/boot/dts/meson8b-mxq.dts
 create mode 100644 arch/arm/boot/dts/meson8b-odroidc1.dts
 create mode 100644 arch/arm/boot/dts/meson8b.dtsi
 create mode 100644 arch/arm/boot/dts/omap5-board-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap5-igep0050.dts
 create mode 100644 arch/arm/boot/dts/r8a7791-porter.dts
 create mode 100644 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-rock2-som.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-rock2-square.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-jaq.dts
 create mode 100644 arch/arm/boot/dts/sama5d2-pinfunc.h
 create mode 100644 arch/arm/boot/dts/sun4i-a10-inet1.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-pcduino2.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
 create mode 100644 arch/arm/boot/dts/sun5i-q8-common.dtsi
 create mode 100644 arch/arm/boot/dts/sun5i-r8-chip.dts
 create mode 100644 arch/arm/boot/dts/sun5i-r8.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
 create mode 100644 arch/arm/boot/dts/sun8i-q8-common.dtsi
 create mode 100644 arch/arm/boot/dts/sunxi-q8-common.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts
 create mode 100644 arch/arm64/boot/dts/altera/Makefile
 create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
 create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
 create mode 100644 arch/arm64/boot/dts/apm/apm-merlin.dts
 create mode 100644 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
 create mode 120000 arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
 rename arch/arm64/boot/dts/freescale/{fsl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} (81%)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
 delete mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip05-d02.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip05.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
