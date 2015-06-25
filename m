From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Jun 2015 15:31:02 -0700
Subject: [GIT PULL 3/5] ARM: SoC: DT updates for v4.2
In-Reply-To: <1435271464-11455-1-git-send-email-khilman@kernel.org>
References: <1435271464-11455-1-git-send-email-khilman@kernel.org>
Message-ID: <1435271464-11455-4-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As usual, quite a few device-tree updates in ARM land.  There was ome
minor churn in DTs due to relicensing under a dual-license, and lots
of little additions of new peripherals, features etc, but nothing
really exciting to call to your attention.  Some higlights, focsuing
on support for new SoCs and boards:

- AT91: new boards: Overkiz,  Acme Systems' Arietta G25
- tegra: HDA support
- bcm: new platforms: Buffalo WXR-1900DHP, SmartRG SR400ac, ASUS RT-AC87U
- mvebu: new platforms: Compulab CM-A510, Armada 385-based Linksys
  boards, DLink DNS-327L
- OMAP: new platforms: Baltos IR5221, LogicPD Torpedo, Toby-Churchill SL50
- ARM: added support for Juno r1 board
- sunxi: A33 SoC support; new boards: A23 EVB, SinA33, GA10H-A33, Mele A1000G
- imx: i.MX7D SoC support; new boards: Armadeus Systems APF6,
  Gateworks GW5510, and aristainetos2 boards
- hisilicon: hi6220 SoC support; new boards: 96boards hikey

Conflicts: None

----------------------------------------------------------------

The following changes since commit 03fa626774a30145bdb97ce1bc909a0cfd419ce6:

  Merge tag 'armsoc-soc' into test-merge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 58c179674329b4d03a9d22df55d95cb0a8da5d85:

  ARM: hisi: revert changes from hisi/hip04-dt branch

----------------------------------------------------------------

Adam Sampson (1):
      ARM: dts: sun7i: Add dts file for pcDuino 3 Nano board

Alan Tull (1):
      ARM: socfpga: dts: add sdram controller dt binding doc

Aleksei Mamlin (2):
      ARM: dts: sun7i: Add dts file for Wexler TAB7200
      dt-bindings: Add vendor-prefix for Wexler

Alexandre Belloni (16):
      ARM: at91/dt: at91sam9rl: fix rtc node
      ARM: at91/dt: at91sam9rlek: add RTC
      ARM: at91/dt: kizbox: use stdout-path
      ARM: at91/dt: at91rm9200ek: use stdout-path
      ARM: at91/dt: at91sam9261ek: use stdout-path
      ARM: at91/dt: at91sam9263ek: use stdout-path
      ARM: at91/dt: at91sam9g20ek: use stdout-path
      ARM: at91/dt: at91sam9m10g45ek use stdout-path
      ARM: at91/dt: at91sam9n12ek: use stdout-path
      ARM: at91/dt: at91sam9rlek: use stdout-path
      ARM: at91/dt: at91sam9x5ek: use stdout-path
      ARM: at91/dt: sama5d3xek: use stdout-path
      ARM: at91/dt: sama5d3 xplained: use stdout-path
      ARM: at91/dt: sama5d4ek: use stdout-path
      ARM: at91/dt: sama5d4 xplained: use stdout-path
      ARM: at91/dt: Add Acme Arietta G25

Andrew Andrianov (1):
      ARM: mvebu: dts: Add dts file for DLink DNS-327L

Andrey Skvortsov (1):
      ARM: dts: add core2 padconf region for am3517

Andrzej Hajda (1):
      ARM: dts: add mmc detect gpio for exynos5422-odroidxu3

Andrzej Pietrasiewicz (1):
      ARM: dts: exynos5420: add nodes for jpeg codec

Anthoine Bourgeois (1):
      ARM: dts: omap3-devkit8000: Add dm9000 support

Antoine Tenart (12):
      ARM: dts: berlin: relicense the berlin2q dtsi under GPLv2/X11
      ARM: dts: berlin: relicense the BG2Q Marvell DMP dts under GPLv2/X11
      ARM: dts: berlin: relicense the berlin2 dtsi under GPLv2/X11
      ARM: dts: berlin: relicense the BG2 Sony NSZ-GS7 dts under GPLv2/X11
      ARM: dts: berlin: relicense the berlin2cd dtsi under GPLv2/X11
      ARM: dts: berlin: relicense the BG2CD Google Chromecast dts under GPLv2/X11
      Documentation: bindings: berlin: consider our dt bindings as unstable
      Documentation: bindings: update the Berlin controllers documentation
      Documentation: bindings: move the Berlin reset documentation
      Documentation: bindings: move the Berlin pinctrl documentation
      Documentation: bindings: move the Berlin clock documentation
      Documentation: bindings: update the berlin chip and system ctrl doc

Ariel D'Alessandro (1):
      ARM: dts: Add DT for Hitex LPC4350 Evaluation Board

Arnd Bergmann (32):
      Merge tag 'sti-dt-for-v4.2-1' of git://git.kernel.org/.../mcoquelin/sti into next/dt
      Merge tag 'hip04-dt-for-4.2' of git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'at91-dt' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'socfpga_dts_for_v4.2' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'sunxi-dt-for-4.2' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'ux500-v4.2-dt' of git://git.kernel.org/.../linusw/linux-stericsson into next/dt
      Merge tag 'v4.2-rockchip-dts1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'socfpga_dts_for_v4.2_part_2' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'tegra-for-4.2-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'arm-soc/for-4.2/dts' of http://github.com/broadcom/stblinux into next/dt
      Merge tag 'pxa-dt-4.2' of https://github.com/rjarzmik/linux into next/dt
      Merge tag 'renesas-dt-for-v4.2' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'rpi-dt-for-armsoc-v4.2' of git://git.kernel.org/.../rpi/linux-rpi into next/dt
      Merge tag 'sti-dt-for-v4.2-2' of git://git.kernel.org/.../mcoquelin/sti into next/dt
      Merge tag 'mvebu-dt-4.2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'at91-dt2' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'berlin-dt-4.2-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt
      Merge tag 'v4.2-rockchip-dts2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'at91-dt3' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge branch 'for-upstream/juno-dts' of git://linux-arm.org/linux-ld into next/dt
      Merge tag 'omap-for-v4.2/dt-pt1' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'qcom-dt-for-4.2' of git://git.kernel.org/.../galak/linux-qcom into next/dt
      Merge tag 'v4.1-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'zynq-dt-for-4.2' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'renesas-dt2-for-v4.2' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'qcom-arm64-for-4.2' of git://git.kernel.org/.../galak/linux-qcom into next/dt
      Merge branch 'for-upstream/juno-dts' of git://linux-arm.org/linux-ld into next/dt
      Merge tag 'mvebu-dt-4.2-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'arm-soc/for-4.2/dts-fixes' of http://github.com/broadcom/stblinux into next/dt
      Merge tag 'v4.1-next-arm64' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'dt-for-armsoc' of git://git.kernel.org/.../linusw/linux-stericsson into next/dt
      ARM: hisi: revert changes from hisi/hip04-dt branch

Baruch Siach (3):
      ARM: digicolor: enable CX92755 on-chip RTC device
      ARM: digicolor: add i2c master controller support
      ARM: bcm2835: dt: Fix i2c0 node name

Ben Dooks (3):
      ARM: at91/dt: sama5d3 xplained: fill in mmc1 and set it to disabled
      ARM: at91/dt: sama5d3 xplained: add mmc0 vqmmc entry
      ARM: at91/dt: sama5d3 xplained: add fixed regulator for vmmc0

Bintian Wang (3):
      arm64: hi6220: Document devicetree bindings for Hisilicon hi6220 SoC
      clk: hi6220: Document devicetree bindings for hi6220 clock
      arm64: dts: Add dts files for Hisilicon Hi6220 SoC

Boris BREZILLON (1):
      ARM: dts: sun6i: add p2wi controller node to dtsi

Boris Brezillon (3):
      USB: atmel: update DT bindings documentation
      ARM: at91/dt: remove useless uhpck clock references from ehci defintions
      ARM: at91/dt: remove useless usb clock

Brian Norris (3):
      ARM: bcm7445: add NAND to DTS
      ARM: bcm63138: add NAND DT support
      ARM: dts: brcmstb: add nodes for SATA controller and PHY

Chen-Yu Tsai (22):
      ARM: dts: sun9i: Add usb clock nodes to a80 dtsi
      ARM: dts: sun9i: Add usb phy nodes to a80 dtsi
      ARM: dts: sun9i: Add USB host controller nodes to a80 dtsi
      ARM: dts: sun9i: Enable USB support on A80 Optimus board
      ARM: dts: sun6i: hummingbird: Enable IR receiver
      ARM: dts: sun6i: hummingbird: Enable P2WI controller
      ARM: dts: sun6i: hummingbird: Add AXP221 PMIC device node
      ARM: dts: sun6i: hummingbird: Add AXP221 regulator nodes
      ARM: dts: sun6i: Add pinmux settings for mmc1 to dtsi
      ARM: dts: sun6i: hummingbird: Enable the onboard WiFi module
      ARM: dts: sun8i: Enable ARM architected timer on A23
      ARM: dts: sun9i: Enable ARM architected timer on A80
      ARM: dts: sun9i: optimus: Switch to phy core regulator bindings for usb phys
      ARM: dts: sun6i: Add cpu clock reference and operating points to dtsi
      ARM: dts: sun6i: Add cpu thermal zones to dtsi
      ARM: sun8i: dt: Enable A23 SMP support
      ARM: dts: sunxi: Update ahb clocks for sun5i and sun7i
      ARM: dts: sun6i: Set PLL6 as parent to AHB1 clock in AHB1 clock node
      ARM: dts: sun9i: Add device node for watchdog
      ARM: dts: sun8i: Add pinmux setting for 8bit mmc2
      ARM: dts: sun8i-a33: Add pinmux setting for uart0 on PB pins
      ARM: dts: sun8i-a33: Add dts for Sinlinx SinA33 development board.

Cory Tusar (1):
      ARM: dts: vf610: Nomenclature fixup for PTC12 pin used in RMII mode.

Daniel Kurtz (1):
      arm64: dts: mt8173: fix some indentation

Dinh Nguyen (10):
      ARM: socfpga: dts: add cpu1-start-addr for Arria 10
      ARM: socfpga: dts: disable the sdmmc, and uart nodes in the base arria10
      ARM: socfpga: dts: enable UART1 for the debug uart
      ARM: socfpga: dts: rename socdk board file to socdk_sdmmc
      ARM: socfpga: dts: Add a clock node for sdmmc CIU
      ARM: socfpga: dts: add clocks to the Arria10 platform
      ARM: socfpga: dts: add the a9-scu node
      ARM: socfpga: dts: add the a9-scu node for arria10
      ARM: socfpga: dts: add enable-method property for cpu nodes
      ARM: socfpga: dts: enable ethernet for Arria10 devkit

Doug Anderson (1):
      ARM: dts: rockchip: Specify VMMC and VQMMC on rk3288-evb

Eliad Peller (1):
      ARM: dts: am335x-evm: add bluetooth support

Enric Balletbo i Serra (2):
      of: Add vendor prefix for Toby Churchill Ltd.
      ARM: dts: am335x-sl50: Add Toby-Churchill SL50 board support.

Eric Anholt (2):
      ARM: bcm2835: dt: Add the mailbox to the device tree
      ARM: bcm2835: dt: Use 0x4 prefix for DMA bus addresses to SDRAM.

Eric Nelson (2):
      ARM: dts: nitrogen6x: use simple-panel instead of display-timings for LVDS0
      ARM: dts: sabrelite: use simple-panel instead of display-timings for LVDS0

Eyal Reizer (2):
      ARM: dts: am437x-gp-evm: add wilink8 support
      ARM: dts: am335x-evm: add mmc3 and wlan definitions to dts

Fabio Estevam (7):
      ARM: dts: hummingboard: Remove unneeded 'fsl,mode' property
      ARM: dts: imx6qdl-hummingboard: Add PCIe support
      ARM: dts: imx6sl-warp: Remove unused regulator
      ARM: dts: imx6sl-warp: Remove USB regulators
      ARM: dts: imx6sl-warp: Fix OTG roles
      ARM: dts: cubox-i: add support for Broadcom Wifi/Bluetooth devices
      ARM: dts: cubox-i/hummingboard: Fix the license text

Fathi Boudra (1):
      ARM: dts: add HiSilicon hip04 ethernet controller resource

Felix Fietkau (2):
      ARM: BCM5301X: Add USB LED for Buffalo WZR-1750DHP
      ARM: BCM5301X: Add DT for Buffalo WXR-1900DHP

Florian Fainelli (7):
      Documentation: DT: Add Broadcom BCM63138 PMB binding
      ARM: dts: BCM63xx: Add PMB busses nodes
      Documentation: DT: Document SMP DT nodes and properties for BCM63138
      ARM: dts: BCM63xx: Add SMP nodes and required properties
      dt-bindings: Add documentation for the BCM63138 timer and syscon-reboot
      ARM: dts: BCM63xx: Add timer and syscon-reboot nodes
      ARM: dts: BCM63xx: re-parent NAND controller node

Frank Li (4):
      ARM: dts: add pinfunc include file to support imx7d
      Document: dt: binding: imx: update document for imx7d support
      ARM: dts: add imx7d soc dtsi file
      ARM: dts: add imx7d-sdb support

Ga?l PORTAY (12):
      ARM: at91/dt: kizbox: rename to at91-kizbox
      ARM: at91/dt: at91-kizbox: sanitize file
      ARM: at91/dt: at91-kizbox: user proper serial uart
      ARM: at91/dt: at91-kizbox: gpio-keys related changes
      ARM: at91/dt: at91-kizbox: leds related changes
      ARM: at91/dt: at91-kizbox: re-size nand partitions
      ARM: at91/dt: at91-kizbox: update chosen node
      ARM: at91/dt: sam9x5: add pinctrl for pwm0
      ARM: at91/dt: add support for kizboxmini
      ARM: at91/dt: add support for kizbox2
      ARM: at91/dt: drop deprecated mainck node from pmc
      ARM: at91/dt: kizbox: fix mismatch LED PWM device

Geert Uytterhoeven (33):
      ARM: shmobile: r8a7740 dtsi: Fix SCIFB naming
      ARM: shmobile: sh73a0 dtsi: Fix SCIFB naming
      ARM: shmobile: r8a73a4: Add IRQC clock to device tree
      ARM: shmobile: r8a7790: Add IRQC clock to device tree
      ARM: shmobile: r8a7791: Add IRQC clock to device tree
      ARM: shmobile: r8a7794: Add IRQC clock to device tree
      ARM: shmobile: r8a7740 dtsi: Use generic names for device nodes
      ARM: shmobile: r8a7778 dtsi: Use generic names for device nodes
      ARM: shmobile: r8a7779 dtsi: Use generic names for device nodes
      ARM: shmobile: r8a7790 dtsi: Use generic names for device nodes
      ARM: shmobile: r8a7791 dtsi: Use generic names for device nodes
      ARM: shmobile: sh73a0 dtsi: Use generic names for device nodes
      ARM: shmobile: ape6evm dts: Use generic names for device nodes
      ARM: shmobile: kzm9d dts: Use generic names for device nodes
      ARM: shmobile: marzen dts: Use generic names for device nodes
      ARM: shmobile: armadillo800eva dts: Use generic names for device nodes
      ARM: shmobile: henninger dts: Add "nor-jedec" compatible value
      ARM: shmobile: bockw-reference dts: Add "nor-jedec" compatible value
      ARM: shmobile: lager dts: Add "nor-jedec" compatible value
      ARM: shmobile: bockw dts: Add "nor-jedec" compatible value
      ARM: shmobile: koelsch dts: Add "nor-jedec" compatible value
      ARM: shmobile: bockw dts: Use generic names for device nodes
      ARM: shmobile: lager dts: Use generic names for device nodes
      ARM: shmobile: koelsch dts: Use generic names for device nodes
      ARM: shmobile: kzm9g dts: Configure the HOME key as wake-up source
      ARM: shmobile: lager dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: koelsch dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: bockw-reference dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: henninger dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: bockw dts: Replace "nor-jedec" by "jedec,spi-nor"
      ARM: shmobile: r8a7794 dtsi: Describe DMA for the serial ports
      ARM: shmobile: r8a7791 dtsi: Describe DMA for the serial ports
      ARM: shmobile: r8a7790 dtsi: Describe DMA for the serial ports

Gregory CLEMENT (1):
      ARM: mvebu: use improved armada spi device tree compatible name for each SoC

Hans de Goede (19):
      ARM: dts: sun4i: Enable tablet keys on Chuwi V7 CW0825
      ARM: dts: sun5i: Stop using different compatibles for ehci/ohci on a13 vs a10s
      ARM: dts: sun5i: Add mmc2 pinmux settings
      ARM: dts: sun5i: Add new Auxtek-t004 board
      ARM: dts: sun5i: Add new Utoo P66 board
      ARM: dts: sunxi: Adjust touchscreen compatible for sun5i and later
      ARM: dts: sunxi: Add address- and size-cells properties to the mmc ctrl nodes
      ARM: dts: sun7i: Add OOB irq support to boards with broadcom sdio wifi
      ARM: dts: sun6i: csq cs908 dts cleanup
      ARM: dts: sun5i: Add broken-hpi property for Utoo-P66 eMMC
      ARM: dts: sun4i: Add A10 SRAM and SRAM controller
      ARM: dts: sun5i: Add A13 and A10s SRAM and SRAM controller
      ARM: dts: sun7i: Add dts file for the Orangepi SBC
      ARM: dts: sun7i: Add dts file for the Orangepi mini SBC
      ARM: dts: sun5i: Enable touchscreen on Utoo P66
      ARM: dts: sun7i: Add dts file for the Jesurun Q5 top set box
      ARM: dts: sun8i: Add usb_clk node for a23/a33
      ARM: dts: sun8i: Add dts file for the GA10H-A33 tablet
      ARM: dts: sun6i: Add a dts file for the Mele A1000G quad top set box

Harald Geyer (2):
      ARM: dts: imx23: Add i2c support
      ARM: dts: imx23-olinuxino: Add i2c support

Hauke Mehrtens (2):
      ARM: BCM5301X: add NAND flash chip description
      ARM: BCM5301X: add IRQ numbers for PCIe controller

Heiko Schocher (1):
      ARM: dts: imx6: add DT for aristainetos2 board

Heiko Stuebner (10):
      ARM: dts: rockchip: add act8846 supplies on rk3288-firefly
      ARM: dts: rockchip: enable tsadc on rk3288 boards
      ARM: dts: rockchip: relicense rk3xxx.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3066a.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3188.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3288-thermal.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3066a-bqcurie2.dts under GPLv2/X11
      ARM: dts: rockchip: relicense rk3188-radxarock.dts under GPLv2/X11
      ARM: dts: rockchip: relicense rk3288.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3288-evb* under GPLv2/X11

Hongzhou Yang (1):
      ARM: dts: mt8135: Add pinctrl/GPIO/EINT node for mt8135.

Imre Kaloz (2):
      ARM: mvebu: add alias for mdio on Armada 38x
      ARM: mvebu: add support for the new Armada 385 based Linksys boards

Inha Song (1):
      ARM: dts: support simple-audio-card for exynos5420 and exynos5422-odroidxu3

Ivan T. Ivanov (7):
      arm64: dts: qcom: Add SPMI PMIC Arbiter node for MSM8916
      arm64: dts: qcom: Add 8x16 chipset SPMI PMIC's nodes
      arm64: dts: qcom: Add MSM8916 restart device node
      arm64: dts: qcom: Add initial set of PMIC and SoC pins for APQ8016 SBC board
      ARM: dts: qcom: Add PM8841 functions device nodes
      ARM: dts: qcom: Add PM8941 functions device nodes
      ARM: dts: qcom: Add PMA8084 functions device nodes

Jacek Anaszewski (2):
      ARM: dts: add JPEG codec device node for exynos3250
      ARM: dts: add support JPEG codec for exynos3250-rinato

Joachim Eastwood (2):
      ARM: dts: Add base DT for NXP LPC18xx
      ARM: dts: Add DT for Embedded Artists LPC4357 Developers Kit

Josh Wu (2):
      ARM: at91/dt: sama5d4: add usart0, usart1 dt nodes
      ARM: at91/dt: sama5: reduce the NFC command register map

Karim BEN BELGACEM (1):
      ARM: STi: DT: STiH407: Fix retime pin mask for PIO5 and PIO35

Kevin Hilman (11):
      Merge tag 'socfpga_dts_for_v4.2_part_3' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'sunxi-dt-for-4.2-2' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'arm-soc/for-4.2/dts-part3' of https://github.com/Broadcom/stblinux into next/dt
      Merge tag 'keystone-dts-for-4.2' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'imx-dt-4.2' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'at91-dt4' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'hi6620-dt-for-4.2' of git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'samsung-dt-3' of git://git.kernel.org/.../kgene/linux-samsung into next/dt
      Merge tag 'v4.1-rc6' into next/dt
      Merge tag 'samsung-dt-4' of git://git.kernel.org/.../kgene/linux-samsung into next/dt
      Merge tag 'omap-for-v4.2/dt-pt2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt

Krzysztof Kozlowski (34):
      ARM: dts: fix pinctrl for s2mps11-irq on exynos5420-arndale-octa
      ARM: dts: Use s3c6410-rtc instead of exynos3250-rtc for exynos3250/4415
      ARM: dts: Use define for s3c-rtc clock id for exynos3250-rinato
      ARM: dts: Use define for s3c-rtc clock id for exynos3250-monk
      ARM: dts: Enable S3C RTC on exynos4412-trats2 and exynos5420-arndale-octa
      ARM: dts: Use last parent for clocks during power domain on/off
      ARM: dts: Remove obsolete MIPI DPHY 'reg' property for exynos4
      ARM: dts: Add syscon property to the MIPI DPHY for exynos4415
      ARM: dts: Add labels to exynos4 nodes
      ARM: dts: Use labels for overriding nodes in exynos4210
      ARM: dts: Use labels for overriding nodes in exynos4210-origen
      ARM: dts: Use labels for overriding nodes in exynos4210-smdkv310
      ARM: dts: Use labels for overriding nodes in exynos4210-trats
      ARM: dts: Use labels for overriding nodes in exynos4212
      ARM: dts: Use labels for overriding nodes in exynos4x12
      ARM: dts: Use labels for overriding nodes in exynos4412
      ARM: dts: Use labels for overriding nodes in exynos4412-odroid
      ARM: dts: Use labels for overriding nodes in exynos4412-smdk4412
      ARM: dts: Use labels for overriding nodes in exynos4412-trats2
      ARM: dts: Use labels for overriding nodes in exynos4412-origen
      ARM: dts: Use labels for overriding nodes in exynos4412-tiny4412
      ARM: dts: Add labels to exynos5 nodes
      ARM: dts: Use labels for overriding nodes in exynos5250
      ARM: dts: Remove duplicated I2C7 nodes in exynos5250-snow
      ARM: dts: Use labels for overriding nodes in exynos5420-arndale-octa
      ARM: dts: Use labels for overriding nodes in exynos542x
      ARM: dts: Use labels for overriding nodes in exynos5420-smdk5420
      ARM: dts: Use labels for overriding nodes in exynos5440 boards
      ARM: dts: Use labels for overriding nodes in exynos5422-odroidxu3
      ARM: dts: s3c2416: Add labels to S3C2416 nodes
      ARM: dts: s3c2416: Use labels for overriding nodes in SMDK2416
      ARM: dts: odroidxu3: Enable wake alarm of S2MPS11 RTC
      of: Add vendor prefix for Hardkernel
      ARM: dts: Add Odroid XU3 Lite support

Kukjin Kim (1):
      Merge branch 'v4.2-next/dt-samsung-3rd' into v4.2-next/dt-samsung-4th

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: add MMCIF max-frequency
      ARM: shmobile: r8a7791: add MMCIF max-frequency

Lad, Prabhakar (1):
      ARM: dts: am437x-gp-evm: add DT nodes for ov2659 sensor

Lee Jones (16):
      ARM: sti: Provide DT nodes for SSC[0..4]
      ARM: sti: Provide DT nodes for SBC SSC[0..2]
      mfd: dt-bindings: Provide human readable defines for LPC mode choosing
      ARM: STi: DT: STiH407: Add Device Tree node for the LPC
      ARM: STi: STiH407: Add DT nodes for for PWM
      ARM: STi: STiH416: Add Pinctrl settings for PWM
      ARM: STi: STiH416: Add DT nodes for PWM
      ARM: STi: STiH416-b2020e: Enable PWM on the B2020 Rev-E
      ARM: STi: STiH407: Add Restart support for STiH407
      ARM: STi: STiH416: Add Restart support for STiH416
      ARM: STi: STiH416: Enable Cortex-A9 PMU support
      ARM: STi: STiH416: Enable PMU IRQs
      ARM: STi: STiH407: Enable Cortex-A9 PMU support
      ARM: STi: STiH407: Enable PMU IRQs
      ARM: STi: Ensure requested STi's SysCfg Controlled IRQs are enabled at boot
      ARM: STi: DT: STih407: Re-order #include <*.dtsi> files

Linus Walleij (11):
      ARM: ux500: define CPU topology
      ARM: ux500: add CoreSight blocks to DTS file
      ARM: ux500: fix lsm303dlh magnetometer compat string
      ARM: ux500: assign the sensor trigger IRQs
      ARM: ux500: add the sensors to the STUIB board
      ARM: ux500: add SCU and WD to device tree
      ARM: scu: document Snoop Control Unit DT bindings
      ARM: ux500: add board documentation
      ARM: ux500: define the backupram in the device tree
      ARM64: juno: add GPIO keys
      ARM: nomadik: set proper compatible for accelerometer

Liviu Dudau (6):
      arm64: Juno: Fix the GIC node address label and the frequency of FAXI clock.
      arm64: Juno: Split juno.dts into juno-base.dtsi and juno.dts.
      arm64: Juno: Add memory mapped timer node
      arm64: Juno: Add GICv2m support in device tree.
      arm64: Add DT support for Juno r1 board.
      Documentation: bindings: Add DT bindings for ARM Juno boards.

Lucas Stach (1):
      ARM: dts: imx6qdl: move HDMI controller to right location in DT

Ludovic Desroches (3):
      ARM: at91/dt: sama5d4: update pinctrl ranges
      ARM: at91/dt: sama5d4 xplained: add regulators for v(q)mmc1 supplies
      ARM: at91/dt: sama5d4ek: mci0 uses slot 0

Marcel Ziswiler (3):
      ARM: tegra: Cardhu device-tree comment spelling fix
      ARM: tegra: Add Tegra30 HDA support
      ARM: tegra: Fix hda2codec_2x clock and reset names

Marcus Cooper (3):
      ARM: sun6i: dt: Add new Mele I7 device
      ARM: sun7i: dt: Add new MK808C device
      ARM: sunxi: dts: split IR pins for A10 and A20

Marek Belisko (2):
      ARM: dts: omap3-gta04: Add hdqw1 support
      ARM: dts: omap3-gta04: Add GSM audio support

Marek Szyprowski (6):
      ARM: dts: add jpeg-codec node for exynos4 and exynos4x12
      ARM: dts: add sysmmu nodes for exynos4
      ARM: dts: add sysmmu nodes for exynos3250
      ARM: dts: add sysmmu nodes for exynos4415
      ARM: dts: add sysmmu nodes for exynos5250
      ARM: dts: add sysmmu nodes for exynos5420

Markus Reichl (4):
      ARM: dts: Add LEDs for exynos5422-odroidxu3
      ARM: dts: Add HS400 support for exynos5422-odroidxu3
      clk: samsung: Add bindings for 32kHz clocks from s2mps11
      ARM: dts: add 'rtc_src' clock to rtc node for exynos5422-odroidxu3

Masahiro Yamada (1):
      ARM: dts: UniPhier: add support for UniPhier SoCs and boards

Maxime Coquelin (3):
      Merge tag 'ib-mfd-arm-4.2' of git://git.kernel.org/.../lee/mfd.git
      ARM: dts: Add ARM System timer as clocksource in armv7m
      ARM: dts: Introduce STM32F429 MCU

Maxime Ripard (45):
      ARM: sun4i: Relicense the A10 DTSI under GPLv2/X11
      ARM: sun5i: Relicense the A10s/A13 DTSI under GPLv2/X11
      ARM: sun7i: hummingbird: Relicense the device tree under GPLv2/X11
      ARM: sun7i: olinuxino micro: Relicense the device tree under GPLv2/X11
      ARM: sun5i: Add a DTSI common to A10s and A13
      ARM: sun5i: a13: Move to the common sun5i DTSI
      ARM: sun5i: a10s: Move to the common sun5i DTSI
      ARM: sun4i: a1000: Convert to DT label based syntax
      ARM: sun4i: ba10 tvbox: Convert to DT label based syntax
      ARM: sun4i: cubieboard: Convert to DT label based syntax
      ARM: sun4i: hackberry: Convert to DT label based syntax
      ARM: sun4i: inet97fv2: Convert to DT label based syntax
      ARM: sun4i: mini xplus: Convert to DT label based syntax
      ARM: sun4i: olinuxino lime: Convert to DT label based syntax
      ARM: sun4i: pcduino: Convert to DT label based syntax
      ARM: sun5i: a10s: olinuxino micro: Convert to DT label based syntax
      ARM: sun5i: a10s: r7 tv dongle: Convert to DT label based syntax
      ARM: sun5i: a13: hsg h702: Convert to DT label based syntax
      ARM: sun5i: a13: olinuxino micro: Convert to DT label based syntax
      ARM: sun5i: a13: olinuxino: Convert to DT label based syntax
      ARM: sun6i: app4 evb1: Convert to DT label based syntax
      ARM: sun6i: colombus: Convert to DT label based syntax
      ARM: sun6i: m9: Convert to DT label based syntax
      ARM: sun7i: bananapi: Convert to DT label based syntax
      ARM: sun7i: cubieboard2: Convert to DT label based syntax
      ARM: sun7i: cubietruck: Convert to DT label based syntax
      ARM: sun7i: hummingbird: Convert to DT label based syntax
      ARM: sun7i: i12 tvbox: Convert to DT label based syntax
      ARM: sun7i: m3: Convert to DT label based syntax
      ARM: sun7i: olinuxino lime: Convert to DT label based syntax
      ARM: sun7i: olinuxino lime2: Convert to DT label based syntax
      ARM: sun7i: olinuxino micro: Convert to DT label based syntax
      ARM: sun7i: pcduino3: Convert to DT label based syntax
      ARM: sun8i: ippo q8h v5: Convert to DT label based syntax
      ARM: sunxi: DT: Add stdout-path property
      ARM: dts: sun7i: Add A20 SRAM and SRAM controller
      ARM: sunxi: dt: Remove the FSF address
      ARM: sunxi: DT: Fix lines over 80 characters
      ARM: sunxi: dt: Fix whitespace errors
      ARM: sunxi: dt: Split the SPI pinctrl groups
      ARM: sun8i: Introduce A23 Evaluation Board Support
      ARM: dts: sunxi: Revert SRAM controller drivers patches
      ARM: dts: sun4i: Add A10 SRAM and SRAM controller
      ARM: dts: sun5i: Add A10s and A13 SRAM and SRAM controller
      ARM: dts: sun7i: Add A20 SRAM and SRAM controller

Michael Niew?hner (1):
      ARM: dts: rockchip: add system-power-controller to act8846 on radxarock

Michael Ring (2):
      ARM: dts: sun7i: Add uart4_pins_b definition
      ARM: dts: sun7i: Add uart4 support for BananaPro, disable uart2

Michal Simek (4):
      ARM: dts: zynq: Add missing alias node for zybo and parallella
      ARM: dts: zynq: Fix stdout-path and bootargs
      PCI: xilinx: Trivial fix in DT example
      of: Add vendor prefix for Ceva

Murali Karicheri (6):
      ARM: dts: k2hk-evm: Add device bindings for netcp driver
      ARM: dts: k2e-evm: Add device bindings for netcp driver
      ARM: dts: k2l-evm: Add device bindings for netcp driver
      ARM: dts: k2hk: fix the netcp range size
      ARM: dts: k2e: fix the netcp range size
      ARM: dts: k2l: fix the netcp range size

Nathan Sullivan (1):
      ARM: zynq: DT: Use the zynq binding with macb

Nicolas Dechesne (2):
      ARM: dts: qcom: apq8064 - Add usb host support to CM QS-600
      ARM: dts: qcom: apq8064 - Add USB OTG support for CM QS-600

Nicolas Ferre (3):
      ARM: at91/dt: sama5d4 xplained: add spi1 on j14 connector
      ARM: at91/dt: sama5d3 xplained: add phy address for macb0
      ARM: at91/dt: at91sam9x5: fix usart1 sck pin definition

Nishanth Menon (1):
      ARM: dts: omap5-uevm: Add Uart wakeup interrupt

Pantelis Antoniou (1):
      ARM: dts: Beaglebone i2c definitions

Peter Chubb (1):
      ARM: dts: exynos5422-odroidxu3: Hook up PWM and use it for LEDs

Peter Crosthwaite (1):
      devicetree: cadence_ttc: Document binding for timer width

Peter Griffin (8):
      ARM: STi: DT: STiH407: Add dt nodes for sdhci and emmc.
      ARM: STi: DT: STiH418: Add dt nodes for sdhci and emmc.
      ARM: DT: STi: STiH407: Add sata DT nodes.
      ARM: DT: STi: STiH407: Update picophyreset for the usb3 controllers usb2 phy
      ARM: DT: STi: STiH407: Add dwc3 usb3 DT node.
      ARM: DT: STi: stihxxx-b2120: Enable USB3 port on stih407-b2120 and stih410-b2120
      ARM: DT: STi: STiH418: Add miphy28lp optional oscillator clock properties
      ARM: DT: STi: STiH418: Enable USB3 port on stih418-b2199.

Philipp Zabel (1):
      ARM: dts: imx6qdl: Add power-domain phandle to CODA device node

Pramod Gurav (1):
      ARM: dts: qcom: apq8064-ifc6410 - Add DT alias for serial port

Priit Laes (1):
      ARM: dts: sun4i: Add initial dts for Gemei G9 tablet

Rafa? Mi?ecki (6):
      ARM: BCM5301X: Add DT for SmartRG SR400ac
      ARM: BCM5301X: Add DT for Asus RT-AC68U
      ARM: BCM5301X: Add DT for Asus RT-AC56U
      ARM: kirkwood: add "jedec,spi-nor" flash compatible binding
      ARM: mvebu: add "jedec,spi-nor" flash compatible binding
      ARM: BCM5301X: Add DT for Asus RT-AC87U

Ray Jui (1):
      ARM: dts: cygnus: Enable NAND support for Cygnus

Robert Jarzmik (5):
      ARM: dts: pxa: add pwri2c to pxa device-tree
      ARM: dts: pxa: add clocks
      ARM: dts: pxa: add pxa27x-udc to pxa27x
      ARM: dts: pxa: add pxa27x-keypad to pxa27x
      ARM: dts: pxa: add pxa-timer to pxa27x and pxa3xx

Ryo Kataoka (2):
      ARM: shmobile: r8a7790: Remove MSIOF address from device tree
      ARM: shmobile: r8a7791: Remove MSIOF address from device tree

Sebastian Hesselbarth (4):
      ARM: dts: dove: Add internal i2c multiplexer node
      ARM: dts: dove: Remove Compulab CM-A510 from Makefile
      ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510
      ARM: dts: dove: Add Compulab SBC-A510 to Makefile

Shawn Guo (1):
      ARM: dts: imx6dl: add imx6dl gpt specific compatible string

Sonny Rao (1):
      ARM: dts: rockchip: Enable Cortex-A12 HW PMU events on rk3288

Srinivas Kandagatla (8):
      ARM: dts: qcom: apq8064 - add RPM regulators support
      ARM: dts: qcom: apq8064-ifc6410 - Add basic regulators
      ARM: dts: qcom: apq8064 - Add usb host support.
      ARM: dts: qcom: apq8064 - Add USB OTG support
      ARM: dts: qcom: apq8064 - Add SATA controller support
      ARM: dts: qcom: apq8064-cm-qs600 - Add basic regulators
      ARM: dts: qcom: apq8064 - Move i2c1 pinctrl to apq8064.dtsi
      ARM: dts: qcom: apq8064 - add i2c3 node for panel.

Stefan Agner (1):
      ARM: dts: add support for Vybrid running on Cortex-M4

Stefan Wahren (4):
      ARM: bcm2835: dt: Add vendor prefix for Raspberry Pi
      ARM: bcm2835: dt: Add root properties for Raspberry Pi
      ARM: bcm2835: dt: Add header file for pinctrl constants
      ARM: bcm2835: dt: Use pinctrl header

Steffen Trumtrar (2):
      ARM: socfpga: socrates: enable gpio0/1
      ARM: socfpga: socrates: add gpio-leds

Stephen Boyd (1):
      ARM: dts: qcom: Add msm8660 PMU node

Suchang Ko (2):
      ARM: at91/dt: sama5d4: add uart0, uart1 dt nodes
      ARM: at91/dt: sama5d4: add spi1, spi2 dt nodes

S?bastien Szymanski (1):
      ARM: dts: Armadeus Systems APF6 family support (i.MX6)

Thierry Reding (5):
      ARM: tegra: cardhu: Add power and volume keys
      ARM: tegra: Add missing HDMI +5V regulator
      ARM: tegra: jetson-tk1: Enable HDA support
      ARM: tegra: venice2: Mark eMMC as non-removable
      ARM: tegra: venice2: Set min-/max-microvolt for VDD_LED supply

Thomas Niederpr?m (1):
      ARM: mxs: fix in tree users of ssd1306

Tim Harvey (1):
      ARM: dts: Gateworks GW5510 support (i.MX6)

Tomeu Vizoso (1):
      ARM: dts: Add syscon property to the MIPI phy in exynos5420

Tony Lindgren (4):
      ARM: OMAP3: Add support for configuring MMC pins as GPIO pins
      ARM: dts: Add minimal support for LogicPD Torpedo DM3730 devkit
      ARM: dts: Fix ldp gpio keys to use defines
      ARM: dts: Enable SDIO card interrupt for 37xx-evm

Tyler Baker (2):
      ARM: dts: add vendor prefix for cubietech
      ARM: dts: add cubietech cubieboard4

Vince Bridgers (2):
      ARM: socfpga: dts: Add multicast bins and unicast filter entries
      ARM: socfpga: dts: Add tx-fifo-depth and rx-fifo-depth properties

Vishnu Patekar (3):
      ARM: dts: sun8i: Add sun8i-a23-a33 dtsi
      ARM: dts: sun8i: Add sun8i-a33 dtsi
      ARM: dts: sun8i: Add ET-Q8 A33 support

Walter Lozano (1):
      ARM: socfpga: dts: Add adxl34x

Yadwinder Singh Brar (1):
      ARM: dts: Add missing irq pinctrl for max77686 on smdk5250

Yegor Yefremov (1):
      ARM: dts: add DTS for Baltos IR5221

Yingjoe Chen (2):
      arm64: dts: mt8173: Fixup pinctrl nodes
      ARM: dts: mt8127: correct uart instance address

Yoshihiro Shimoda (4):
      ARM: shmobile: r8a7790: add USB-DMAC device nodes
      ARM: shmobile: r8a7790: Enable DMA for HSUSB
      ARM: shmobile: r8a7791: add USB-DMAC device nodes
      ARM: shmobile: r8a7791: Enable DMA for HSUSB

Yunzhi Li (1):
      ARM: dts: rockchip: add properties for dwc2 usb otg controller

Zhou Wang (2):
      ARM: dts: hip04: add GPIO pieces
      mtd: hisilicon: add device tree node for NAND controller

ludovic.desroches at atmel.com (1):
      ARM: at91/dt: sama5d4: fix dma conf for aes, sha and tdes nodes


 .../arm/altera/socfpga-sdram-controller.txt     |   12 +
 .../devicetree/bindings/arm/arm-boards          |   66 +
 .../bindings/arm/bcm/brcm,bcm2835.txt           |   31 +-
 .../bindings/arm/bcm/brcm,bcm63138.txt          |   76 +
 .../bindings/arm/hisilicon/hisilicon.txt        |   87 ++
 .../devicetree/bindings/arm/marvell,berlin.txt  |  100 +-
 Documentation/devicetree/bindings/arm/scu.txt   |   25 +
 .../devicetree/bindings/arm/ux500/boards.txt    |   83 ++
 .../devicetree/bindings/clock/hi6220-clock.txt  |   34 +
 .../devicetree/bindings/clock/imx7d-clock.txt   |   13 +
 .../bindings/clock/marvell,berlin.txt           |   31 +
 .../devicetree/bindings/pci/xilinx-pcie.txt     |    2 +-
 .../bindings/pinctrl/berlin,pinctrl.txt         |   43 +
 .../bindings/pinctrl/fsl,imx7d-pinctrl.txt      |   27 +
 .../devicetree/bindings/reset/berlin,reset.txt  |   23 +
 .../bindings/reset/brcm,bcm63138-pmb.txt        |   19 +
 .../devicetree/bindings/rtc/s3c-rtc.txt         |    3 +-
 .../devicetree/bindings/spi/sh-msiof.txt        |    2 +-
 .../bindings/timer/cadence,ttc-timer.txt        |    4 +
 .../devicetree/bindings/usb/atmel-usb.txt       |   25 +
 .../devicetree/bindings/vendor-prefixes.txt     |    8 +
 arch/arm/boot/dts/Makefile                      |   71 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts      |  532 +++++++
 arch/arm/boot/dts/am335x-bone-common.dtsi       |   66 +
 arch/arm/boot/dts/am335x-evm.dts                |   81 ++
 arch/arm/boot/dts/am335x-sl50.dts               |  482 +++++++
 arch/arm/boot/dts/am3517.dtsi                   |   11 +
 arch/arm/boot/dts/am437x-gp-evm.dts             |  144 +-
 arch/arm/boot/dts/armada-370-db.dts             |    2 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts  |  357 +++++
 .../arm/boot/dts/armada-370-synology-ds213j.dts |    2 +-
 arch/arm/boot/dts/armada-370-xp.dtsi            |    2 -
 arch/arm/boot/dts/armada-370.dtsi               |    4 +
 arch/arm/boot/dts/armada-375-db.dts             |    2 +-
 arch/arm/boot/dts/armada-375.dtsi               |    6 +-
 arch/arm/boot/dts/armada-385-db-ap.dts          |    2 +-
 arch/arm/boot/dts/armada-385-linksys-caiman.dts |  114 ++
 arch/arm/boot/dts/armada-385-linksys-cobra.dts  |  114 ++
 arch/arm/boot/dts/armada-385-linksys.dtsi       |  332 +++++
 arch/arm/boot/dts/armada-388-db.dts             |    2 +-
 arch/arm/boot/dts/armada-388-gp.dts             |    2 +-
 arch/arm/boot/dts/armada-388-rd.dts             |    2 +-
 arch/arm/boot/dts/armada-38x.dtsi               |    8 +-
 arch/arm/boot/dts/armada-398-db.dts             |    2 +-
 arch/arm/boot/dts/armada-39x.dtsi               |    6 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts       |    2 +-
 arch/arm/boot/dts/armada-xp-db.dts              |    2 +-
 arch/arm/boot/dts/armada-xp-gp.dts              |    2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts  |    2 +-
 arch/arm/boot/dts/armada-xp.dtsi                |    8 +
 arch/arm/boot/dts/armv7-m.dtsi                  |    6 +
 arch/arm/boot/dts/at91-ariettag25.dts           |   79 ++
 arch/arm/boot/dts/at91-kizbox.dts               |  159 +++
 arch/arm/boot/dts/at91-kizbox2.dts              |  216 +++
 arch/arm/boot/dts/at91-kizboxmini.dts           |  129 ++
 arch/arm/boot/dts/at91-sama5d3_xplained.dts     |   35 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts     |   28 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts            |    7 +-
 arch/arm/boot/dts/at91rm9200.dtsi               |    4 +-
 arch/arm/boot/dts/at91rm9200ek.dts              |    4 +
 arch/arm/boot/dts/at91sam9260.dtsi              |    4 +-
 arch/arm/boot/dts/at91sam9261.dtsi              |    4 +-
 arch/arm/boot/dts/at91sam9261ek.dts             |    3 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |    4 +-
 arch/arm/boot/dts/at91sam9263ek.dts             |    3 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi     |    3 +-
 arch/arm/boot/dts/at91sam9g45.dtsi              |    8 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts          |    3 +-
 arch/arm/boot/dts/at91sam9n12.dtsi              |    5 +-
 arch/arm/boot/dts/at91sam9n12ek.dts             |    3 +-
 arch/arm/boot/dts/at91sam9rl.dtsi               |   15 +-
 arch/arm/boot/dts/at91sam9rlek.dts              |   11 +-
 arch/arm/boot/dts/at91sam9x5.dtsi               |   56 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi             |    3 +-
 arch/arm/boot/dts/axp209.dtsi                   |    5 -
 arch/arm/boot/dts/bcm-cygnus.dtsi               |   12 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts        |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts             |    4 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |    8 +-
 arch/arm/boot/dts/bcm2835.dtsi                  |   13 +-
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts     |   97 ++
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts     |   84 ++
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    |    7 +
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts    |    9 +-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |    1 +
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts  |    1 +
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts   |  120 ++
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts     |    1 +
 .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts   |    1 +
 .../boot/dts/bcm47081-buffalo-wzr-900dhp.dts    |    1 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts     |   65 +
 .../boot/dts/bcm4709-buffalo-wxr-1900dhp.dts    |  128 ++
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts     |    1 +
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi   |   24 +
 arch/arm/boot/dts/bcm5301x.dtsi                 |   36 +
 arch/arm/boot/dts/bcm63138.dtsi                 |   43 +
 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts      |   23 +
 arch/arm/boot/dts/bcm7445.dtsi                  |   59 +
 arch/arm/boot/dts/bcm958300k.dts                |   16 +
 arch/arm/boot/dts/bcm963138dvt.dts              |   12 +
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts      |   34 +-
 arch/arm/boot/dts/berlin2.dtsi                  |   34 +-
 .../boot/dts/berlin2cd-google-chromecast.dts    |   34 +-
 arch/arm/boot/dts/berlin2cd.dtsi                |   34 +-
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts      |   34 +-
 arch/arm/boot/dts/berlin2q.dtsi                 |   34 +-
 arch/arm/boot/dts/cx92755.dtsi                  |   17 +
 arch/arm/boot/dts/cx92755_equinox.dts           |    4 +
 arch/arm/boot/dts/dove-cm-a510.dts              |   38 -
 arch/arm/boot/dts/dove-cm-a510.dtsi             |  195 +++
 arch/arm/boot/dts/dove-sbc-a510.dts             |  182 +++
 arch/arm/boot/dts/dove.dtsi                     |   40 +-
 arch/arm/boot/dts/emev2-kzm9d.dts               |    4 +-
 arch/arm/boot/dts/exynos3250-monk.dts           |    3 +-
 arch/arm/boot/dts/exynos3250-rinato.dts         |    7 +-
 arch/arm/boot/dts/exynos3250.dtsi               |   48 +-
 arch/arm/boot/dts/exynos4.dtsi                  |  150 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |  418 +++---
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |  280 ++--
 arch/arm/boot/dts/exynos4210-trats.dts          |  592 ++++----
 arch/arm/boot/dts/exynos4210.dtsi               |   72 +-
 arch/arm/boot/dts/exynos4212.dtsi               |   12 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  732 +++++-----
 arch/arm/boot/dts/exynos4412-odroidx.dts        |   16 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |  892 ++++++------
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |  210 +--
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |   54 +-
 arch/arm/boot/dts/exynos4412-trats2.dts         | 1339 +++++++++---------
 arch/arm/boot/dts/exynos4412.dtsi               |   20 +-
 arch/arm/boot/dts/exynos4415.dtsi               |   15 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi       |    8 +-
 arch/arm/boot/dts/exynos4x12.dtsi               |  290 ++--
 arch/arm/boot/dts/exynos5.dtsi                  |    6 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |   12 +
 arch/arm/boot/dts/exynos5250-snow.dts           |   46 +-
 arch/arm/boot/dts/exynos5250.dtsi               |  332 ++++-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |  652 ++++-----
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |    2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |  645 ++++-----
 arch/arm/boot/dts/exynos5420.dtsi               |  305 +++-
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   |  479 +++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts |   20 +
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      |  339 +----
 arch/arm/boot/dts/exynos5440-sd5v1.dts          |   10 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts       |   85 +-
 arch/arm/boot/dts/exynos5440.dtsi               |    4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |    2 +-
 arch/arm/boot/dts/imx23-olinuxino.dts           |    6 +
 arch/arm/boot/dts/imx23.dtsi                    |   40 +-
 arch/arm/boot/dts/imx28-cfa10036.dts            |    3 +
 arch/arm/boot/dts/imx6dl-apf6dev.dts            |   60 +
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts    |  159 +++
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts    |   97 ++
 arch/arm/boot/dts/imx6dl-cubox-i.dts            |    5 +-
 arch/arm/boot/dts/imx6dl-gw551x.dts             |   55 +
 arch/arm/boot/dts/imx6dl-hummingboard.dts       |    5 +-
 arch/arm/boot/dts/imx6dl.dtsi                   |    4 +
 arch/arm/boot/dts/imx6q-apf6dev.dts             |   64 +
 arch/arm/boot/dts/imx6q-cubox-i.dts             |    5 +-
 arch/arm/boot/dts/imx6q-gw551x.dts              |   55 +
 arch/arm/boot/dts/imx6q-hummingboard.dts        |    5 +-
 arch/arm/boot/dts/imx6qdl-apf6.dtsi             |  158 +++
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi          |  479 +++++++
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi    |  633 +++++++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi          |    5 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi           |  314 ++++
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi     |   19 +-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi  |    5 +-
 arch/arm/boot/dts/imx6qdl-microsom.dtsi         |  108 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi       |   30 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi        |   30 +-
 arch/arm/boot/dts/imx6qdl.dtsi                  |   57 +-
 arch/arm/boot/dts/imx6sl-warp.dts               |   39 +-
 arch/arm/boot/dts/imx7d-pinfunc.h               | 1038 ++++++++++++++
 arch/arm/boot/dts/imx7d-sdb.dts                 |  408 ++++++
 arch/arm/boot/dts/imx7d.dtsi                    |  486 +++++++
 arch/arm/boot/dts/k2e-evm.dts                   |    1 +
 arch/arm/boot/dts/k2e-netcp.dtsi                |  206 +++
 arch/arm/boot/dts/k2e.dtsi                      |    1 +
 arch/arm/boot/dts/k2hk-evm.dts                  |    1 +
 arch/arm/boot/dts/k2hk-netcp.dtsi               |  208 +++
 arch/arm/boot/dts/k2hk.dtsi                     |    1 +
 arch/arm/boot/dts/k2l-evm.dts                   |    1 +
 arch/arm/boot/dts/k2l-netcp.dtsi                |  189 +++
 arch/arm/boot/dts/k2l.dtsi                      |    1 +
 arch/arm/boot/dts/kirkwood-b3.dts               |    2 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts         |    2 +-
 arch/arm/boot/dts/kirkwood-dir665.dts           |    2 +-
 arch/arm/boot/dts/kirkwood-dreamplug.dts        |    2 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi            |    2 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts  |    2 +-
 arch/arm/boot/dts/kirkwood-netxbig.dtsi         |    2 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi      |    2 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts        |    2 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi        |    2 +-
 arch/arm/boot/dts/kirkwood-t5325.dts            |    2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi           |    2 +-
 arch/arm/boot/dts/kizbox.dts                    |  150 --
 .../boot/dts/logicpd-torpedo-37xx-devkit.dts    |  157 ++
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi      |  162 +++
 arch/arm/boot/dts/lpc18xx.dtsi                  |  114 ++
 arch/arm/boot/dts/lpc4350-hitex-eval.dts        |   45 +
 arch/arm/boot/dts/lpc4350.dtsi                  |   39 +
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts     |   41 +
 arch/arm/boot/dts/lpc4357.dtsi                  |   39 +
 arch/arm/boot/dts/mt8127.dtsi                   |    8 +-
 arch/arm/boot/dts/mt8135-pinfunc.h              | 1302 +++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi                   |   29 +
 arch/arm/boot/dts/omap3-devkit8000.dts          |   41 +
 arch/arm/boot/dts/omap3-evm-common.dtsi         |    1 +
 arch/arm/boot/dts/omap3-gta04.dtsi              |   37 +
 arch/arm/boot/dts/omap3-ldp.dts                 |   18 +-
 arch/arm/boot/dts/omap5-uevm.dts                |   14 +-
 arch/arm/boot/dts/pxa27x.dtsi                   |   46 +-
 arch/arm/boot/dts/pxa2xx.dtsi                   |    7 +-
 arch/arm/boot/dts/pxa3xx.dtsi                   |   29 +-
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts     |  100 ++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts      |  136 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi             |  175 ++-
 arch/arm/boot/dts/qcom-msm8660.dtsi             |    5 +
 arch/arm/boot/dts/qcom-pm8841.dtsi              |   18 +
 arch/arm/boot/dts/qcom-pm8941.dtsi              |  133 +-
 arch/arm/boot/dts/qcom-pma8084.dtsi             |   92 ++
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |    2 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  |   11 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |    2 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |   10 +-
 arch/arm/boot/dts/r8a7778-bockw-reference.dts   |    2 +-
 arch/arm/boot/dts/r8a7778-bockw.dts             |    4 +-
 arch/arm/boot/dts/r8a7778.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts            |    6 +-
 arch/arm/boot/dts/r8a7779.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |    4 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |   66 +-
 arch/arm/boot/dts/r8a7791-henninger.dts         |    2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |    4 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |   79 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |   45 +
 arch/arm/boot/dts/rk3066a-bqcurie2.dts          |   44 +-
 arch/arm/boot/dts/rk3066a.dtsi                  |   44 +-
 arch/arm/boot/dts/rk3188-radxarock.dts          |   45 +-
 arch/arm/boot/dts/rk3188.dtsi                   |   44 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts        |   44 +-
 arch/arm/boot/dts/rk3288-evb-rk808.dts          |   44 +-
 arch/arm/boot/dts/rk3288-evb.dtsi               |   67 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi           |   14 +
 arch/arm/boot/dts/rk3288-popmetal.dts           |    6 +
 arch/arm/boot/dts/rk3288-thermal.dtsi           |   40 +-
 arch/arm/boot/dts/rk3288.dtsi                   |   58 +-
 arch/arm/boot/dts/rk3xxx.dtsi                   |   44 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts          |   86 +-
 arch/arm/boot/dts/s3c2416.dtsi                  |   18 +-
 arch/arm/boot/dts/sama5d3.dtsi                  |   11 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi               |    9 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |  218 ++-
 arch/arm/boot/dts/sh73a0-kzm9g.dts              |    1 +
 arch/arm/boot/dts/sh73a0.dtsi                   |   10 +-
 arch/arm/boot/dts/socfpga.dtsi                  |   20 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi          |  352 ++++-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi    |   74 +
 ...ocdk.dts => socfpga_arria10_socdk_sdmmc.dts} |   36 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts   |   16 +
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts |   31 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi               |  175 +++
 arch/arm/boot/dts/ste-href-stuib.dtsi           |   50 +
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi      |    7 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi      |    5 +-
 arch/arm/boot/dts/ste-snowball.dts              |   23 +-
 arch/arm/boot/dts/stih407-b2120.dts             |    2 +-
 arch/arm/boot/dts/stih407-family.dtsi           |  231 ++-
 arch/arm/boot/dts/stih407-pinctrl.dtsi          |    2 +
 arch/arm/boot/dts/stih407.dtsi                  |   28 +
 arch/arm/boot/dts/stih410-b2120.dts             |   10 +
 arch/arm/boot/dts/stih416-b2020e.dts            |   10 +
 arch/arm/boot/dts/stih416-pinctrl.dtsi          |   50 +
 arch/arm/boot/dts/stih416.dtsi                  |   66 +-
 arch/arm/boot/dts/stih418-b2199.dts             |   27 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi            |   13 +
 arch/arm/boot/dts/stm32f429-disco.dts           |   71 +
 arch/arm/boot/dts/stm32f429.dtsi                |  214 +++
 arch/arm/boot/dts/sun4i-a10-a1000.dts           |  211 +--
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts      |  185 +--
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts |   40 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      |  226 +--
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts        |  171 +++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts       |  200 ++-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts    |   13 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       |  123 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts      |  193 +++
 arch/arm/boot/dts/sun4i-a10-marsboard.dts       |   20 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      |  149 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts           |   13 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts         |   13 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  |  228 +--
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         |  189 +--
 arch/arm/boot/dts/sun4i-a10.dtsi                |  166 ++-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts    |  154 ++
 arch/arm/boot/dts/sun5i-a10s-mk802.dts          |   13 +-
 .../arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  328 ++---
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts   |  139 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi               |  651 ++-------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts        |  143 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts |  155 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts       |  245 ++--
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts        |  226 +++
 arch/arm/boot/dts/sun5i-a13.dtsi                |  608 ++------
 arch/arm/boot/dts/sun5i.dtsi                    |  609 ++++++++
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts       |   63 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts        |  145 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts     |  108 +-
 arch/arm/boot/dts/sun6i-a31-i7.dts              |  149 ++
 arch/arm/boot/dts/sun6i-a31-m9.dts              |  161 ++-
 .../arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts |  149 ++
 arch/arm/boot/dts/sun6i-a31.dtsi                |  133 +-
 arch/arm/boot/dts/sun6i-a31s-cs908.dts          |   48 +-
 arch/arm/boot/dts/sun6i-a31s.dtsi               |    5 -
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        |  271 ++--
 arch/arm/boot/dts/sun7i-a20-bananapro.dts       |   25 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |  205 +--
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |  331 ++---
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts     |  426 +++---
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts       |  267 ++--
 arch/arm/boot/dts/sun7i-a20-m3.dts              |  191 +--
 arch/arm/boot/dts/sun7i-a20-mk808c.dts          |  148 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  |  197 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |  301 ++--
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  411 +++---
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts   |  250 ++++
 arch/arm/boot/dts/sun7i-a20-orangepi.dts        |  228 +++
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts   |  194 +++
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts        |  217 +--
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts  |  183 +++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  196 ++-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |  636 +++++++++
 arch/arm/boot/dts/sun8i-a23-evb.dts             |  134 ++
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts   |    5 -
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts     |  117 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                |  557 +-------
 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts      |   88 ++
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts      |  125 ++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts  |  129 ++
 arch/arm/boot/dts/sun8i-a33.dtsi                |   97 ++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts     |   99 ++
 arch/arm/boot/dts/sun9i-a80-optimus.dts         |   72 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                |  145 +-
 arch/arm/boot/dts/sunxi-common-regulators.dtsi  |    5 -
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |    4 +
 arch/arm/boot/dts/tegra124-venice2.dts          |    3 +
 arch/arm/boot/dts/tegra124.dtsi                 |    4 +-
 arch/arm/boot/dts/tegra20-seaboard.dts          |   12 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |   30 +-
 arch/arm/boot/dts/tegra30.dtsi                  |   15 +
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts      |   79 ++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi         |  110 ++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts     |   79 ++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi        |  117 ++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts     |   80 ++
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi        |  117 ++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts     |   79 ++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi        |  110 ++
 arch/arm/boot/dts/uniphier-support-card.dtsi    |   65 +
 arch/arm/boot/dts/vf-colibri.dtsi               |    2 +-
 arch/arm/boot/dts/vf610-cosmic.dts              |    2 +-
 arch/arm/boot/dts/vf610-pinfunc.h               |    2 +-
 arch/arm/boot/dts/vf610-twr.dts                 |    2 +-
 arch/arm/boot/dts/vf610m4-colibri.dts           |   99 ++
 arch/arm/boot/dts/vf610m4.dtsi                  |   50 +
 arch/arm/boot/dts/zynq-7000.dtsi                |    4 +-
 arch/arm/boot/dts/zynq-parallella.dts           |    9 +-
 arch/arm/boot/dts/zynq-zc702.dts                |    3 +-
 arch/arm/boot/dts/zynq-zc706.dts                |    3 +-
 arch/arm/boot/dts/zynq-zed.dts                  |    3 +-
 arch/arm/boot/dts/zynq-zybo.dts                 |    8 +-
 arch/arm/mach-omap2/control.c                   |    3 +
 arch/arm/mach-omap2/control.h                   |    3 +
 arch/arm/mach-omap2/pdata-quirks.c              |   22 +
 arch/arm/mach-sti/Kconfig                       |    1 +
 arch/arm64/boot/dts/Makefile                    |    1 +
 arch/arm64/boot/dts/arm/Makefile                |    2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi          |  154 ++
 arch/arm64/boot/dts/arm/juno-clocks.dtsi        |    4 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi   |   61 +
 arch/arm64/boot/dts/arm/juno-r1.dts             |  116 ++
 arch/arm64/boot/dts/arm/juno.dts                |  129 +-
 arch/arm64/boot/dts/hisilicon/Makefile          |    5 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts  |   31 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |  171 +++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |   41 +-
 .../boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi    |   30 +
 .../boot/dts/qcom/apq8016-sbc-soc-pins.dtsi     |   21 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |    3 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi       |    1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |   25 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi            |   99 ++
 include/dt-bindings/clock/r8a73a4-clock.h       |    1 +
 include/dt-bindings/clock/r8a7790-clock.h       |    3 +
 include/dt-bindings/clock/r8a7791-clock.h       |    3 +
 include/dt-bindings/clock/r8a7794-clock.h       |    3 +
 include/dt-bindings/clock/samsung,s2mps11.h     |   23 +
 include/dt-bindings/mfd/st-lpc.h                |   15 +
 include/dt-bindings/pinctrl/am43xx.h            |    1 +
 include/dt-bindings/pinctrl/bcm2835.h           |   27 +
 402 files changed, 29441 insertions(+), 9239 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
 create mode 100644 Documentation/devicetree/bindings/arm/scu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/boards.txt
 create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/reset/berlin,reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir5221.dts
 create mode 100644 arch/arm/boot/dts/am335x-sl50.dts
 create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts
 create mode 100644 arch/arm/boot/dts/armada-385-linksys-caiman.dts
 create mode 100644 arch/arm/boot/dts/armada-385-linksys-cobra.dts
 create mode 100644 arch/arm/boot/dts/armada-385-linksys.dtsi
 create mode 100644 arch/arm/boot/dts/at91-ariettag25.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini.dts
 create mode 100644 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
 create mode 100644 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
 create mode 100644 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
 create mode 100644 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
 create mode 100644 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
 delete mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
 create mode 100644 arch/arm/boot/dts/dove-sbc-a510.dts
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-apf6dev.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw551x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apf6dev.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw551x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-apf6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw551x.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx7d-sdb.dts
 create mode 100644 arch/arm/boot/dts/imx7d.dtsi
 create mode 100644 arch/arm/boot/dts/k2e-netcp.dtsi
 create mode 100644 arch/arm/boot/dts/k2hk-netcp.dtsi
 create mode 100644 arch/arm/boot/dts/k2l-netcp.dtsi
 delete mode 100644 arch/arm/boot/dts/kizbox.dts
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-som.dtsi
 create mode 100644 arch/arm/boot/dts/lpc18xx.dtsi
 create mode 100644 arch/arm/boot/dts/lpc4350-hitex-eval.dts
 create mode 100644 arch/arm/boot/dts/lpc4350.dtsi
 create mode 100644 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
 create mode 100644 arch/arm/boot/dts/lpc4357.dtsi
 create mode 100644 arch/arm/boot/dts/mt8135-pinfunc.h
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
 rename arch/arm/boot/dts/{socfpga_arria10_socdk.dts => socfpga_arria10_socdk_sdmmc.dts} (57%)
 mode change 100755 => 100644
 create mode 100644 arch/arm/boot/dts/stm32f429-disco.dts
 create mode 100644 arch/arm/boot/dts/stm32f429.dtsi
 create mode 100644 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
 create mode 100644 arch/arm/boot/dts/sun5i.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31-i7.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-mk808c.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-orangepi.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-a33.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-a23-evb.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33.dtsi
 create mode 100644 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-support-card.dtsi
 create mode 100644 arch/arm/boot/dts/vf610m4-colibri.dts
 create mode 100644 arch/arm/boot/dts/vf610m4.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/juno-base.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/juno-r1.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8916.dtsi
 create mode 100644 include/dt-bindings/clock/samsung,s2mps11.h
 create mode 100644 include/dt-bindings/mfd/st-lpc.h
 create mode 100644 include/dt-bindings/pinctrl/bcm2835.h
