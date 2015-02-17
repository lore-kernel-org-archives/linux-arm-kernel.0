From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Feb 2015 00:33:25 -0800
Subject: [GIT PULL 4/7] ARM: SoC DT updates
In-Reply-To: <1424162008-23768-1-git-send-email-olof@lixom.net>
References: <1424162008-23768-1-git-send-email-olof@lixom.net>
Message-ID: <1424162008-23768-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT changes continue to be the bulk of our merge window contents.

We continue to have a large set of changes across the board as new platforms
and drivers are added.

Some of the new platforms are:
- Alphascale ASM9260
- Marvell Armada 388
- CSR Atlas7
- TI Davinci DM816x
- Hisilicon HiP01
- ST STiH418

There have also been some sweeping changes, including relicensing of DTS
contents from GPL to GPLv2+/X11 so that the same files can be reused in
other non-GPL projects more easily. There's also been changes to the
DT Makefile to make it a little less conflict-ridden and churny down
the road.


Conflicts: None

----------------------------------------------------------------

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/dt-for-linus

for you to fetch changes up to 880c0d140deb12d5be39a96375fcc42ad357f17d:

  Merge tag 'samsung-dt-4' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into next/dt

----------------------------------------------------------------

Aaro Koskinen (1):
      ARM: dts: N950/N9: add twl_power

Addy Ke (1):
      ARM: dts: rockchip: set dw_mmc max-freq 150Mhz

Aleksei Mamlin (2):
      ARM: dts: sunxi: Add missing mdio label
      ARM: dts: sun4i: Add Marsboard A10 board

Alexander Morozov (1):
      ARM: at91: sama5d3xek/dt: use dt ids for wm8904

Alexander Stein (2):
      dt: atmel_ac97c: Add device tree documentation
      ARM: at91/dt: sam9263: Add ac97 device node

Alexandru Gagniuc (2):
      ARM: sun4i: dt: Add pin muxing options for SPI
      ARM: sun4i: dt: cubieboard: Enable SPI0

Andrey Gusakov (2):
      ARM: shmobile: r8a7790: add MLB+ clock
      ARM: shmobile: r8a7791: add MLB+ clock

Andy Yan (1):
      ARM: dts: rockchip: add rk3288 hdmi nodes

Anson Huang (3):
      ARM: dts: imx6q: update cpufreq volt/freq table
      ARM: dts: imx6dl: correct cpufreq volt/freq table
      ARM: dts: imx6sx: add i.mx6sx sabreauto board support

Anton Bondarenko (1):
      ARM: dts: imx6q: enable dma for ecspi5

Arnaud Ebalard (1):
      ARM: tegra: Update isl29028 compatible string to use isil vendor prefix

Barry Song (1):
      ARM: dts: drop MARCO platform DT stuff

Baruch Siach (2):
      ARM: devicetree: document supported Conexant Digicolor SoC
      ARM: digicolor: add minimal device tree description

Ben Dooks (2):
      ARM: shmobile: r8a7790 dtsi: Change to using clock-indices
      ARM: shmobile: r8a7791 dtsi: Change to using clock-indices

Benoit Parrot (3):
      ARM: dts: am4372: add VPFE DT node entries
      ARM: dts: am43x-epos-evm: add VPFE device tree data
      ARM: dts: am437x-gp-evm: add VPFE device tree data

Beomho Seo (2):
      ARM: dts: remove unnecessary gpio-key nodes for exynos3250 boards
      ARM: dts: use macro in gpio keys for exynos3250 boards

Bhupesh Sharma (3):
      Documentation: DT: Add bindings for FSL NS16550A UART
      Documentation: DT: Add entry for FSL LS2085A SoC and Simulator model
      Documentation: DT: Add entry for FSL Management Complex

Bo Shen (1):
      ARM: at91: at91sam9n12ek/dt: use dt ids for wm8904

Chanwoo Choi (4):
      ARM: dts: Add PPMU dt node for exynos3250
      ARM: dts: Add PPMU dt node for exynos4 and exynos4210
      ARM: dts: Add PPMU node for exynos3250-monk and exynos3250-rinato
      ARM: dts: Add PPMU node for exynos4412-trats2

Chen-Yu Tsai (25):
      ARM: dts: sun6i: hummingbird: Add ethernet phy reset gpio properties
      ARM: dts: sunxi: Enable thermal sensor support for RTP on sun[457]i
      ARM: dts: sun7i: Add cpu clock reference and operating points to dtsi
      ARM: dts: sun5i: Add cpu clock reference and operating points to dtsi
      ARM: dts: sun4i: Add cpu clock reference and operating points to dtsi
      ARM: dts: sunxi: Add dtsi for AXP209 PMIC
      ARM: dts: sun7i: Add cpu thermal zones to dtsi
      ARM: dts: sun5i: Add cpu thermal zones to dtsi
      ARM: dts: sun4i: Add cpu thermal zones to dtsi
      ARM: dts: sun7i: cubieboard2: add axp209 regulator nodes
      ARM: dts: sun7i: cubietruck: add axp209 regulator nodes
      ARM: dts: sun5i: hsg-h702: add axp209 regulator nodes
      ARM: dts: sun4i: cubieboard: add axp209 regulator nodes
      ARM: dts: sun9i: Add mmc module clock nodes for A80
      ARM: dts: sun9i: Add clock-indices property for bus gate clocks
      ARM: dts: sunxi: Use label to reference pio in sunxi-common-regulators
      ARM: dts: sun9i: Add pinmux setting for mmc0
      ARM: dts: sun6i: Convert hummingbird a31 dts to label references
      ARM: dts: sun9i: Add mmc config clock nodes
      ARM: dts: sun9i: Add mmc controller nodes to the A80 dtsi
      ARM: dts: sun9i: Convert a80 optimus board dts to label referencing
      ARM: dts: sun9i: Enable mmc0 on A80 Optimus Board
      ARM: dts: sun9i: Add 8 bit mmc pinmux setting for mmc2
      ARM: dts: sun9i: Enable mmc2 on A80 Optimus Board
      ARM: dts: sun6i: Add resistive touchscreen controller node to dtsi

Chris Zhong (2):
      ARM: dts: rockchip: add RK3288 suspend support
      ARM: dts: rockchip: add suspend settings for rk3288-evb-rk808

Christoph Junghans (1):
      ARM: Kirkwood: Added support for pogoplug e02 (pink/gray)

Dan Haab (1):
      ARM: BCM5301X: Add DT for Luxul XWC-1000

Daniel Kurtz (1):
      ARM: dts: rockchip: Add rk3288 vop and display-subsystem

Daniel Lezcano (1):
      ARM: dts: rockchip: Add rockchip timer node for rk3288

Darren Etheridge (1):
      ARM: dts: am437x-sk-evm: add VPFE device tree data

Dave Gerlach (1):
      ARM: dts: am437x-sk-evm: Hook dcdc2 as the cpu0-supply

Dmitry Lifshitz (1):
      ARM: dts: cm-t3x: add NAND support

Dmitry Osipenko (1):
      ARM: dts: tegra20: fix GR3D, DSI unit and reg base addresses

Dylan Reid (1):
      ARM: tegra: Enable the mic-detect gpio on Acer Chromebook 13

Eddie Huang (3):
      ARM: mediatek: add UART dts for mt8127 and mt8135
      DTS: serial: Add bindings document for the Mediatek UARTs
      ARM: mediatek: dts: Add UART dts for MT8127 and MT8135 boards

Eric Nelson (3):
      ARM: dts: sabrelite: add i2c2
      ARM: dts: sabrelite: add hdmi
      ARM: dts: sabrelite: add i2c3

Evgeni Dobrev (2):
      ARM: dts: kirkwood: enable phy driver for SATA controller on 88f6192
      Kirkwood: add support for Seagate BlackArmor NAS220

FUKAUMI Naoki (3):
      dt-bindings: add vendor prefix and root compatible property for Rockchip boards
      ARM: dts: rockchip: add dts for Firefly Firefly-RK3288 boards
      ARM: dts: rockchip: add dts for ChipSPARK Rayeager PX2 board

Fabio Estevam (3):
      ARM: dts: imx: Update VPU compatible strings
      ARM: dts: imx6qdl: Remove OCRAM clock from VPU node
      ARM: dts: imx6sx-sdb: Add QSPI support

Felipe Balbi (10):
      ARM: dts: am437x-sk: remove internal pulls from QSPI
      ARM: dts: am437x-sk: add explicit MMC0 pinmux
      ARM: dts: am437x-sk: remove ethernet pulls
      ARM: dts: am437x-sk: add explicit pinmux for both USB instances
      ARM: dts: am437x-sk: remove internal i2c pullups
      ARM: dts: am437x-sk: remove DSS pulls
      ARM: dts: am57xx-beagle-x15: Add dual ethernet
      ARM: dts: add support for AM437x IDK
      ARM: dts: am437x-sk: add power button binding
      ARM: dts: am437x-idk: add gpio-based power key

Gabriel FERNANDEZ (3):
      ARM: DT: STiH407: Add DRM dt nodes
      ARM: DT: STiH410: Add DRM dt nodes
      ARM: DT: STi: STiH407: Add DT node for MiPHY28lp

Geert Uytterhoeven (23):
      ARM: shmobile: genmai dts: Replace status value "ok" by "okay"
      ARM: shmobile: armadillo800eva dts: Replace status value "ok" by "okay"
      ARM: shmobile: lager dts: Replace status value "ok" by "okay"
      ARM: shmobile: henninger dts: Replace status value "ok" by "okay"
      ARM: shmobile: koelsch dts: Replace status value "ok" by "okay"
      ARM: shmobile: alt dts: Replace status value "ok" by "okay"
      ARM: shmobile: kzm9g-reference dts: Replace status value "ok" by "okay"
      ARM: shmobile: ape6evm-reference: Correct BSC bus range
      ARM: shmobile: r8a7740 dtsi: Change to using clock-indices
      ARM: shmobile: r8a7779 dtsi: Change to using clock-indices
      ARM: shmobile: r8a7794 dtsi: Change to using clock-indices
      ARM: shmobile: r8a7791: Correct mask for GIC PPI interrupts
      ARM: shmobile: r8a7794: Correct mask for GIC PPI interrupts
      ARM: shmobile: sh73a0 dtsi: Add SoC-specific FSI2 compatible property
      ARM: shmobile: r8a7790 dtsi: Drop "renesas,rcar_sound" compatible value
      ARM: shmobile: r8a7791 dtsi: Drop "renesas,rcar_sound" compatible value
      PM / Domains: Add DT bindings for the R-Mobile System Controller
      ARM: shmobile: r8a7740 dtsi: Add PM domain support
      ARM: shmobile: Add DT bindings for Renesas memory controllers
      ARM: shmobile: r8a73a4 dtsi: Add memory-controller nodes
      ARM: shmobile: r8a7740 dtsi: Add memory-controller node
      ARM: shmobile: sh73a0 dtsi: Add memory-controller nodes
      PM / Domains: R-Mobile SYSC: Document SH-Mobile AG5 (sh73a0) binding

Gregory CLEMENT (33):
      ARM: mvebu: a38x: Add more pinctrl functions
      ARM: mvebu: a38x: Add missing labels
      ARM: mvebu: Document the Device Tree binding for the Armada 388 SoC
      ARM: mvebu: Add Device Tree description of the Armada 388 SoC
      ARM: mvebu: Add Armada 388 General Purpose Development Board support
      ARM: mvebu: Armada 385 GP: Add regulators to the SATA port
      ARM: mvebu: armada-370-db: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-370: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-370-mirabox: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-370-netgear-rn102: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-370-netgear-rn104: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-370-rd: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-370-synology-ds213j: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-370-xp: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-375-db: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-375: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-380: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-388-db: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-385: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-388-rd: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-38x: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-axpwifiap: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-db: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-gp: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-lenovo-ix4-300d: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-matrix: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-mv78230: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-mv78260: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-mv78460: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-netgear-rn2120: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-openblocks-ax3-4: Relicense the device tree under GPLv2+/X11
      ARM: mvebu: armada-xp-synology-ds414: Relicense the device tree under GPLv2+/X11

Gwenhael Goavec-Merou (1):
      ARM: imx: apf51dev: add gpio-backlight support

H. Nikolaus Schaller (5):
      ARM: dts: omap3-gta04: Fix backup-battery charging in devicetree file.
      ARM: dts: omap3-gta04: Fix audio node malformatting
      ARM: dts: omap3-gta04: Enable mcbps2 necessary for audio
      ARM: dts: omap3-gta04: Enable twl audio vibra support
      ARM: dts: omap3-gta04: Enable power-off using twl4030

Hans de Goede (20):
      ARM: dts: sun6i: Add pinmux settings for the ir pins
      ARM: dts: sun6i: Add ir_clk node
      ARM: dts: sun6i: Add ir node
      ARM: dts: sun6i: Enable ir receiver on the Mele M9
      ARM: dts: sun4i: Add lradc node
      ARM: dts: sun5i: Add lradc node
      ARM: dts: sun7i: Add lradc node
      ARM: dts: sun6i: Add sun6i-a31s.dtsi
      ARM: dts: sun6i: Add dts file for CSQ CS908 board
      ARM: dts: sunxi: Add simplefb nodes for de_be0-lcd0, de_be0-lcd0-tve0 pipelines
      ARM: dts: sun8i: Add lradc node to sun8i-a23.dtsi
      ARM: dts: sun8i: Enable lradc on a23-ippo-q8h-v5
      ARM: dts: sun8i: Add dts file for Ippo Q8H v1.2 tablets
      ARM: dts: sun7i: Add dts file for Bananapro board
      ARM: dts: sun4i: Add dts file for Chuwi V7 CW0825 tablet
      ARM: dts: sun4i: Add mk802 board
      ARM: dts: sun4i: Add mk802ii board
      ARM: dts: sun5i: Add mk802_a10s board
      ARM: dts: sun4i: Add Hyundau A7HD board
      ARM: dts: sun5i: Enable axp209 support on A13-OLinuxIno

Heiko Stuebner (7):
      clk: rockchip: add id for watchdog pclk on rk3288
      Merge branch 'v3.20-clk/new-ids' into v3.20-armsoc/dts
      ARM: dts: rockchip: add rk3288 watchdog clock
      ARM: dts: rockchip: add cpu and gpu regulators to rk3288-evb-act8846
      ARM: dts: rockchip: housekeeping off i2c0 on rk3288-evb boards
      ARM: dts: rockchip: enable vops and hdmi output on rk3288-firefly and -evb
      ARM: dts: rockchip: move the hdmi ddc-i2c-bus property to the actual boards

Hiroyuki Yokoyama (1):
      ARM: shmobile: r8a7794: Add SYS-DMAC clocks to device tree

Hisashi Nakamura (3):
      ARM: shmobile: koelsch: Fix QSPI mode of SPI-Flash into mode3
      ARM: shmobile: lager: Fix QSPI mode of SPI-Flash into mode3
      ARM: shmobile: r8a7794: Add QSPI clock to device tree

Howard Chen (2):
      ARM: mediatek: Add sysirq device node to mt6592 dtsi
      dt-bindings: add mt6592 compatible string for mediatek sysirq

Huang Lin (1):
      clk: rockchip: add clock IDs for the PVTM clocks

Inha Song (1):
      ARM: dts: Add sound nodes for exynos4412-trats2

Inki Dae (2):
      ARM: dts: add fimd device support for exynos3250-rinato
      ARM: dts: add Panel device support for exynos3250-rinato

Jaewon Kim (6):
      ARM: dts: Add exynos_usbphy node for exynos3250
      ARM: dts: Add hsotg node for exynos3250
      ARM: dts: Enable USB node for exynos3250-rinato
      ARM: dts: Enable USB node for exynos3250-monk
      ARM: dts: Add regulator-haptic node for exynos3250-rinato
      ARM: dts: Add regulator-haptic node for exynos3250-monk

Javier Martinez Canillas (6):
      ARM: dts: Add power and lid GPIO keys pinctrl for exynos5250-snow
      ARM: dts: Add lid GPIO key device node for Peach boards
      ARM: dts: Set Peach boards USB WebCam regulators to always on
      ARM: dts: Configure regulators for suspend on exynos Peach boards
      clk: exynos5420: Add IDs for clocks used in DISP1 power domain
      ARM: dts: Add DISP1 power domain for exynos5420

Jisheng Zhang (2):
      ARM: dts: berlin: add pmu node for BG2Q and BG2CD
      ARM: dts: berlin: add PPI cpu mask to twd timer interrupts

Josh Wu (1):
      ARM: at91: sama5d4: dts: change the nand compatible string

Kazuya Mizuguchi (1):
      ARM: shmobile: r8a7794: Add USBDMAC[01] clocks to device tree

Kever Yang (1):
      clk: rockchip: add clock ID for usbphy480m_src

Kevin Hilman (1):
      ARM: dts: add on-board INA231 sensors for exynos5422-odroidxu3

Koji Matsuoka (1):
      ARM: shmobile: r8a7794: Add I2C clocks to device tree

Krzysztof Kozlowski (4):
      ARM: dts: Add Maxim 77693 fuel gauge node for exynos4412-trats2
      ARM: dts: Add suspend configuration for max77686 regulators for exynos4412-trats2
      ARM: dts: Switch max77686 regulators to GPIO control for exynos4412-trats2
      ARM: dts: Add max77693 charger node for exynos4412-trats2

Kuninori Morimoto (4):
      ARM: shmobile: r8a7790: tidyup #sound-dai-cells settings
      ARM: shmobile: r8a7791: tidyup #sound-dai-cells settings
      ARM: shmobile: r8a7790: add SRC interrupt number on DTSI
      ARM: shmobile: r8a7791: add SRC interrupt number on DTSI

Laurent Pinchart (1):
      ARM: shmobile: ape6evm: Fix LAN9220 VDDVARIO voltage

Ludovic Desroches (1):
      ARM: at91/dt: sama5d4: add pioD controller

Magnus Damm (3):
      ARM: shmobile: r8a7779: Use R8A7779_CLK_P as SCIF parent clock
      ARM: shmobile: r8a7779: Use MSTP for SCIF clocks
      ARM: shmobile: r8a7779: Add TWD device to DTS

Marek Belisko (3):
      ARM: dts: omap3-gta04: Add handling for tv output
      ARM: dts: omap3-gta04: Fix a GPIO line for bma180 node
      ARM: dts: omap3-gta04: Add ramp value for twl4030 audio

Marek Szyprowski (3):
      ARM: dts: convert to generic power domain bindings for exynos DT
      ARM: dts: add 'dr_mode' property to hsotg devices for exynos boards
      ARM: dts: reduce total RAM by 22 MiB for exynos5422-odroidxu3

Matthias Brugger (3):
      ARM: mediatek: dts: Add uart to mt6589
      ARM: mediatek: dts: Add uart to Aquaris5
      ARM: mediatek: dts: Add uart to mt6592

Maxime COQUELIN (2):
      ARM: dts: Add STiH418 SoC support
      ARM: dts: STiH418: Add B2199 board support

Maxime Ripard (13):
      ARM: mvebu: a38x: Fix node names
      ARM: mvebu: A38x: Remove redundant pinctrl informations
      ARM: mvebu: Add a number of pinctrl functions
      ARM: mvebu: Add Armada 385 Access Point Development Board support
      ARM: sunxi: DT: Convert to device tree includes
      ARM: sunxi: DT: convert DTs to use common GPIOs includes
      ARM: sunxi: DT: Convert the DTs to use a header for the DMA arguments
      ARM: sunxi: DT: Convert the DTs to use a header for the pinctrl nodes
      ARM: sunxi: DT: Convert the DTs to use the GIC headers
      ARM: sunxi: DT: Convert the DTs to use the generic interrupt header
      ARM: sun7i: cubieboard2: Relicense the device tree under GPLv2/X11
      ARM: sun7i: cubietruck: Relicense the device tree under GPLv2/X11
      ARM: sun6i: Enable ARM arch timers

Michael Heimpold (1):
      ARM: dts: imx28-evk: remove duplicate property

Michal Simek (2):
      ARM: zynq: DT: Fix binding for cadence WDT
      ARM: zynq: DT: Add aliases node

Mugunthan V N (1):
      ARM: dts: dra72-evm: Add qspi device

NeilBrown (5):
      ARM: dts: omap3-gta04: add comments about gpios
      ARM: dts: omap3-gta04: enable power-off for wifi card.
      ARM: dts: omap3-gta04: add gyroscope
      ARM: dts: omap3-gta04: only power DSS when necessary.
      ARM: dts: omap3-gta04: Disable keypad

Nicolas Ferre (1):
      ARM: dts: re-fromat AT91 part to match other entries

Nishanth Menon (1):
      ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan node

Oleksij Rempel (3):
      ARM: dts: add DT for Alphascale ASM9260 SoC
      ARM: add alphascale,acc.txt bindings documentation
      add Alphascale to vendor-prefixes.txt

Olof Johansson (33):
      Merge tag 'renesas-dt-cleanups-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'berlin-dt-for-3.20-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt
      Merge tag 'v3.20-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'mvebu-dt-3.20' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'atlas7-init-dts-for-3.20' of git://git.kernel.org/.../baohua/linux into next/dt
      Merge tag 'at91-dt' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge branch 'asm/dt' into next/dt
      ARM: dts: move alphascale in makefile
      Merge tag 'renesas-dt-cleanups2-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'sti-dt-for-v3.20-1' of git://git.stlinux.com/devel/kernel/linux-sti into next/dt
      Merge tag 'omap-for-v3.20/dt-pt1' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'renesas-dt2-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'qcom-dt-for-3.20' of git://git.kernel.org/.../galak/linux-qcom into next/dt
      Merge tag 'omap-for-v3.20/dt-pt2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'bcm5301x-dt-2015-01-20' of https://github.com/hauke/linux into next/dt
      Merge tag 'v3.20-rockchip-dts1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'mvebu-dt-3.20-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'v3.20-next-dts2' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'imx-dt-3.20' of git://git.kernel.org/.../shawnguo/linux into next/dt
      ARM: dts: imx6q: sort dtbs in makefile
      Merge tag 'tegra-for-3.20-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'samsung-dt' of git://git.kernel.org/.../kgene/linux-samsung into next/dt
      Merge tag 'sunxi-dt-for-3.20' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'at91-dt2' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'v3.20-rockchip-dts2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'samsung-dt-2' of git://git.kernel.org/.../kgene/linux-samsung into next/dt
      Merge tag 'samsung-dt-3' of git://git.kernel.org/.../kgene/linux-samsung into next/dt
      Merge tag 'zynq-dt-for-3.20' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'v3.20-rockchip-dts3' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'omap-for-v3.20/dt-pt3-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'mvebu-dt-3.20-3' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'samsung-dt-4' of git://git.kernel.org/.../kgene/linux-samsung into next/dt

Pankaj Dubey (1):
      Documentation: dt-bindings: add exynos-chipid binding information

Paul Bolle (1):
      ARM: mvebu: make DTS comments reflect DEBUG_LL changes

Pavel Machek (1):
      ARM: dts: omap3-n900: cleanup english

Peter Griffin (3):
      ARM: STi: DT: STiH407: Add usb2 picophy dt nodes
      ARM: STi: DT: STiH410: Add usb2 picophy dt nodes
      ARM: STi: DT: STiH410: Add DT nodes for the ehci and ohci usb controllers.

Peter Robinson (1):
      ARM: dts: Only build dtb if associated Arch and/or SoC is enabled

Philippe Reynes (1):
      apf27dev: add max5821 to the dts

Pramod Gurav (1):
      ARM: dts: qcom: Add Support for SD Card Detect for ifc6410 board

Rafa? Mi?ecki (3):
      ARM: BCM5301X: Drop unused poll-interval from gpio-keys
      ARM: BCM5301X: Add LEDs for Buffalo devices
      ARM: BCM5301X: Add DT for Buffalo WZR-900DHP

Richard Kunze (2):
      ARM: dts: use all remaining MTD space foor rootfs of Iomega ix2-200
      ARM: dts: add gpio_poweroff support for Iomega ix2-200

Robert Nelson (1):
      ARM: dts: imx6dl-udoo: Add board support based off imx6q-udoo

Roger Quadros (4):
      ARM: dts: dra7-evm: Add extcon nodes for USB
      ARM: dts: dra72-evm: Add extcon nodes for USB
      ARM: dts: am57xx-beagle-x15: Add extcon nodes for USB
      ARM: dts: am57xx-beagle-x15: Fix USB2 mode

Ryo Kataoka (1):
      ARM: shmobile: r8a7791: Add IPMMU-SGX clock to device tree

Sanchayan Maity (1):
      ARM: dts: vfxxx: Add SNVS node

Sergei Shtylyov (1):
      ARM: shmobile: r8a7791: fix MSTP8 input clocks

Shawn Guo (1):
      Merge branch 'imx/soc' into imx/dt

Shinobu Uehara (3):
      ARM: shmobile: r8a7794: Add USB clocks to device tree
      ARM: shmobile: r8a7794: Add SDHI clocks to device tree
      ARM: shmobile: r8a7794: Add MMCIF clock to device tree

Simon Horman (1):
      ARM: shmobile: dts: koelsch: Fix flash partition label and size

Sjoerd Simons (1):
      ARM: dts: Add dts file for Odroid XU3 board

Soren Brinkmann (4):
      ARM: zynq: DT: Add USB to device tree
      ARM: zynq: DT: Add pinctrl information
      ARM: zynq: DT: Remove bogus value from 'bias-disable' property
      ARM: zynq: DT: Add pinctrl information to USB nodes

Stefan Agner (4):
      ARM: dts: vf610: enable watchdog for Cortex-A5 dt's
      ARM: dts: vf-colibri: add CLKOUT pin to pinctrl of FEC1
      ARM: dts: vf610: add system reset controller and syscon-reboot
      ARM: vf610: use zero based naming for GPIO nodes

Steffen Trumtrar (1):
      ARM: i.MX53: dts: add sahara module

Stephen Boyd (1):
      ARM: dts: qcom: Correct IPQ8064 tlmm interrupt

Sylvain Rochet (1):
      ARM: at91/dt: disable pull-up on vbus-gpio (PB16) to reduce power consumption

Sylwester Nawrocki (3):
      ARM: dts: Fix CLK_UART_ISP_SCLK clock assignment in exynos4x12.dtsi
      ARM: dts: Fix CLK_MOUT_CAMn parent clocks assignment for exynos4412-trats2
      ARM: dts: Add syscon phandle to the video-phy node for Exynos4

Thierry Reding (1):
      ARM: tegra: Fix unit address for Cortex-A9 TWD timer

Thomas Petazzoni (2):
      dt: bindings: update mvebu-mbus DT binding with new compatible properties
      ARM: mvebu: fix compatible strings of MBus on Armada 375 and Armada 38x

Tony Lindgren (4):
      ARM: dts: Add basic dm816x device tree configuration
      ARM: dts: Add basic clocks for dm816x
      ARM: dts: Add minimal support for dm8168-evm
      ARM: dts: Fix dm816x pinctrl and syscon so they are children of SCM

Ulrich Hecht (5):
      ARM: shmobile: ape6evm: fix compatible string for Ethernet controller
      ARM: shmobile: ape6evm: synchronize dts with reference platform
      ARM: shmobile: ape6evm: Add LEDs to the device tree
      ARM: shmobile: ape6evm: Add keypad to the device tree
      ARM: shmobile: r8a73a4: Add r8a73a4-ape6evm.dtb to ARCH_SHMOBILE_MULTI

Vignesh R (1):
      ARM: dts: DRA7X: drop id property in pcie_phy

Vishnu Patekar (2):
      ARM: sunxi: dts: Add PS2 nodes to dtsi for A10,A20
      ARM: sunxi: dts: Add A10/A20 PS2 pin muxing options

Wang Long (1):
      ARM: dts: Add hip01-ca9x2 dts file

Yingjoe Chen (1):
      ARM: mediatek: Add sysirq in mt6589/mt8135/mt8127 dtsi

YoungJun Cho (2):
      ARM: dts: add fimd device node for exynos4415
      ARM: dts: add mipi dsi device node for exynos4415

Zhiwu Song (1):
      ARM: dts: add init dts file for CSR atlas7 SoC

Zoltan HERPAI (1):
      ARM: dts: pcduino: Enable user LED and button support for pcDuino


 .../devicetree/bindings/arm/armada-38x.txt      |   7 +
 .../devicetree/bindings/arm/digicolor.txt       |   6 +
 .../bindings/arm/exynos/power_domain.txt        |   2 +-
 Documentation/devicetree/bindings/arm/fsl.txt   |   8 +
 .../bindings/arm/hisilicon/hisilicon.txt        |  25 +
 .../bindings/arm/mediatek/mediatek,sysirq.txt   |   1 +
 .../devicetree/bindings/arm/rockchip.txt        |  10 +
 .../bindings/arm/samsung/exynos-chipid.txt      |  12 +
 Documentation/devicetree/bindings/arm/sirf.txt  |   6 +-
 .../devicetree/bindings/bus/mvebu-mbus.txt      |   4 +-
 .../bindings/clock/alphascale,acc.txt           | 115 +++
 .../bindings/iommu/samsung,sysmmu.txt           |   6 +-
 .../devicetree/bindings/media/s5p-mfc.txt       |   4 +-
 .../renesas-memory-controllers.txt              |  44 +
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt   |  40 +
 .../bindings/power/renesas,sysc-rmobile.txt     |  99 +++
 .../devicetree/bindings/serial/mtk-uart.txt     |   2 +
 .../devicetree/bindings/serial/of-serial.txt    |  12 +
 .../devicetree/bindings/sound/atmel_ac97c.txt   |  20 +
 .../devicetree/bindings/vendor-prefixes.txt     |   4 +
 .../devicetree/bindings/video/exynos_dsim.txt   |   4 +-
 .../devicetree/bindings/video/samsung-fimd.txt  |   4 +-
 arch/arm/boot/dts/Makefile                      | 356 +++++---
 arch/arm/boot/dts/alphascale-asm9260-devkit.dts |  13 +
 arch/arm/boot/dts/alphascale-asm9260.dtsi       |  63 ++
 arch/arm/boot/dts/am4372.dtsi                   |  16 +
 arch/arm/boot/dts/am437x-gp-evm.dts             | 106 +++
 arch/arm/boot/dts/am437x-idk-evm.dts            | 405 +++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts             | 217 +++--
 arch/arm/boot/dts/am43x-epos-evm.dts            |  53 ++
 arch/arm/boot/dts/am57xx-beagle-x15.dts         | 157 ++++
 arch/arm/boot/dts/armada-370-db.dts             |  40 +-
 arch/arm/boot/dts/armada-370-mirabox.dts        |  40 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts  |  41 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts  |  41 +-
 arch/arm/boot/dts/armada-370-rd.dts             |  40 +-
 .../arm/boot/dts/armada-370-synology-ds213j.dts |  41 +-
 arch/arm/boot/dts/armada-370-xp.dtsi            |  40 +-
 arch/arm/boot/dts/armada-370.dtsi               |  40 +-
 arch/arm/boot/dts/armada-375-db.dts             |  40 +-
 arch/arm/boot/dts/armada-375.dtsi               |  42 +-
 arch/arm/boot/dts/armada-380.dtsi               |  43 +-
 arch/arm/boot/dts/armada-385-db-ap.dts          | 178 ++++
 arch/arm/boot/dts/armada-385-rd.dts             |  97 ---
 arch/arm/boot/dts/armada-385.dtsi               |  43 +-
 .../{armada-385-db.dts => armada-388-db.dts}    |  49 +-
 arch/arm/boot/dts/armada-388-gp.dts             | 414 ++++++++++
 arch/arm/boot/dts/armada-388-rd.dts             | 132 +++
 arch/arm/boot/dts/armada-388.dtsi               |  70 ++
 arch/arm/boot/dts/armada-38x.dtsi               | 136 +++-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts       |  46 +-
 arch/arm/boot/dts/armada-xp-db.dts              |  40 +-
 arch/arm/boot/dts/armada-xp-gp.dts              |  40 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts |  41 +-
 arch/arm/boot/dts/armada-xp-matrix.dts          |  40 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi        |  40 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi        |  40 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi        |  40 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts  |  41 +-
 .../arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  40 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts  |  41 +-
 arch/arm/boot/dts/armada-xp.dtsi                |  40 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |  21 +
 arch/arm/boot/dts/at91sam9n12ek.dts             |   2 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi             |   9 +
 arch/arm/boot/dts/atlas7-evb.dts                | 110 +++
 arch/arm/boot/dts/atlas7.dtsi                   | 813 +++++++++++++++++++
 arch/arm/boot/dts/axp209.dtsi                   |  97 +++
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    |  68 +-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts    |  60 ++
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |   1 -
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts  |   1 -
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts     |   1 -
 .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts   |  68 +-
 .../boot/dts/bcm47081-buffalo-wzr-900dhp.dts    |  37 +
 arch/arm/boot/dts/berlin2.dtsi                  |   2 +-
 arch/arm/boot/dts/berlin2cd.dtsi                |   7 +-
 arch/arm/boot/dts/berlin2q.dtsi                 |  10 +-
 arch/arm/boot/dts/cx92755.dtsi                  | 113 +++
 arch/arm/boot/dts/cx92755_equinox.dts           |  74 ++
 arch/arm/boot/dts/dm8168-evm.dts                | 129 +++
 arch/arm/boot/dts/dm816x-clocks.dtsi            | 250 ++++++
 arch/arm/boot/dts/dm816x.dtsi                   | 392 +++++++++
 arch/arm/boot/dts/dra7-evm.dts                  |  31 +
 arch/arm/boot/dts/dra7.dtsi                     |   2 -
 arch/arm/boot/dts/dra72-evm.dts                 | 108 +++
 arch/arm/boot/dts/exynos3250-monk.dts           |  63 +-
 arch/arm/boot/dts/exynos3250-rinato.dts         | 133 ++-
 arch/arm/boot/dts/exynos3250.dtsi               | 106 ++-
 arch/arm/boot/dts/exynos4.dtsi                  | 134 ++-
 arch/arm/boot/dts/exynos4210-trats.dts          |   1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |   1 +
 arch/arm/boot/dts/exynos4210.dtsi               |   9 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   1 +
 arch/arm/boot/dts/exynos4412-trats2.dts         | 212 +++--
 arch/arm/boot/dts/exynos4415.dtsi               |  34 +
 arch/arm/boot/dts/exynos4x12.dtsi               |   9 +-
 arch/arm/boot/dts/exynos5250-snow.dts           |  16 +
 arch/arm/boot/dts/exynos5250.dtsi               |  12 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts      | 100 ++-
 arch/arm/boot/dts/exynos5420.dtsi               |  27 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      | 371 +++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts       | 101 ++-
 arch/arm/boot/dts/hip01-ca9x2.dts               |  51 ++
 arch/arm/boot/dts/hip01.dtsi                    | 110 +++
 arch/arm/boot/dts/imx27-apf27dev.dts            |  21 +
 arch/arm/boot/dts/imx27.dtsi                    |   2 +-
 arch/arm/boot/dts/imx28-evk.dts                 |   1 -
 arch/arm/boot/dts/imx51-apf51dev.dts            |  14 +
 arch/arm/boot/dts/imx53.dtsi                    |  11 +-
 arch/arm/boot/dts/imx6dl-udoo.dts               |  18 +
 arch/arm/boot/dts/imx6dl.dtsi                   |   2 +-
 arch/arm/boot/dts/imx6q-udoo.dts                | 124 +--
 arch/arm/boot/dts/imx6q.dtsi                    |   4 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi        |  33 +
 arch/arm/boot/dts/imx6qdl-udoo.dtsi             | 134 +++
 arch/arm/boot/dts/imx6qdl.dtsi                  |   5 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts          | 146 ++++
 arch/arm/boot/dts/imx6sx-sdb.dts                |  39 +
 arch/arm/boot/dts/kirkwood-6192.dtsi            |   2 +
 .../arm/boot/dts/kirkwood-blackarmor-nas220.dts | 173 ++++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts   |   8 +-
 arch/arm/boot/dts/kirkwood-pogo_e02.dts         | 134 +++
 arch/arm/boot/dts/marco-evb.dts                 |  54 --
 arch/arm/boot/dts/marco.dtsi                    | 757 -----------------
 arch/arm/boot/dts/mt6589-aquaris5.dts           |  12 +-
 arch/arm/boot/dts/mt6589.dtsi                   |  52 +-
 arch/arm/boot/dts/mt6592.dtsi                   |  51 +-
 arch/arm/boot/dts/mt8127-moose.dts              |   4 +
 arch/arm/boot/dts/mt8127.dtsi                   |  52 +-
 arch/arm/boot/dts/mt8135-evbp1.dts              |   4 +
 arch/arm/boot/dts/mt8135.dtsi                   |  54 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi             |  58 ++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi           |   3 +-
 arch/arm/boot/dts/omap3-gta04.dtsi              |  99 ++-
 arch/arm/boot/dts/omap3-n900.dts                |   3 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi            |   5 +
 arch/arm/boot/dts/omap3-sbc-t3517.dts           |   4 +
 arch/arm/boot/dts/omap3-sbc-t3530.dts           |  10 +-
 arch/arm/boot/dts/omap3-sbc-t3730.dts           |   5 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts      |  12 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi             |   2 +-
 arch/arm/boot/dts/r7s72100-genmai.dts           |   2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           | 173 +++-
 arch/arm/boot/dts/r8a73a4.dtsi                  |  10 +
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |   4 +-
 arch/arm/boot/dts/r8a7740.dtsi                  | 115 ++-
 arch/arm/boot/dts/r8a7779.dtsi                  |  39 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |  15 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |  62 +-
 arch/arm/boot/dts/r8a7791-henninger.dts         |   4 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |  19 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  69 +-
 arch/arm/boot/dts/r8a7794-alt.dts               |   4 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |  82 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts          | 468 +++++++++++
 arch/arm/boot/dts/rk3288-evb-act8846.dts        |  27 +
 arch/arm/boot/dts/rk3288-evb-rk808.dts          |  54 +-
 arch/arm/boot/dts/rk3288-evb.dtsi               |  25 +
 arch/arm/boot/dts/rk3288-firefly-beta.dts       |  71 ++
 arch/arm/boot/dts/rk3288-firefly.dts            |  71 ++
 arch/arm/boot/dts/rk3288-firefly.dtsi           | 490 +++++++++++
 arch/arm/boot/dts/rk3288.dtsi                   | 111 +++
 arch/arm/boot/dts/s5pv210-aquila.dts            |   1 +
 arch/arm/boot/dts/s5pv210-goni.dts              |   1 +
 arch/arm/boot/dts/s5pv210-smdkv210.dts          |   1 +
 arch/arm/boot/dts/sama5d3xmb.dtsi               |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |  15 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts    |   2 +-
 arch/arm/boot/dts/sh73a0.dtsi                   |  18 +-
 arch/arm/boot/dts/stih407-b2120.dts             |   3 +-
 arch/arm/boot/dts/stih407-family.dtsi           |  53 ++
 arch/arm/boot/dts/stih407.dtsi                  | 151 ++++
 arch/arm/boot/dts/stih410.dtsi                  | 138 ++++
 arch/arm/boot/dts/stih418-b2199.dts             |  78 ++
 arch/arm/boot/dts/stih418-clock.dtsi            | 348 ++++++++
 arch/arm/boot/dts/stih418.dtsi                  |  99 +++
 arch/arm/boot/dts/stihxxx-b2120.dtsi            |  13 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts           |  23 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts      |  10 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts | 100 +++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      |  58 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts       |  21 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts    | 105 +++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       |   8 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts       | 183 +++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      |  11 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts           | 109 +++
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts         | 113 +++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  |  21 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         |  68 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                | 204 ++++-
 arch/arm/boot/dts/sun5i-a10s-mk802.dts          | 125 +++
 .../arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  72 +-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts   |  25 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi               |  68 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts        |  59 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts |  25 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts       |  75 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                | 112 ++-
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts       |  13 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts        |  21 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts     | 185 ++---
 arch/arm/boot/dts/sun6i-a31-m9.dts              |  31 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                | 182 +++--
 arch/arm/boot/dts/sun6i-a31s-cs908.dts          | 104 +++
 arch/arm/boot/dts/sun6i-a31s.dtsi               |  58 ++
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        |  28 +-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts       | 262 ++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 101 ++-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 125 ++-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts     |  38 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts       |  40 +-
 arch/arm/boot/dts/sun7i-a20-m3.dts              |  18 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  |  24 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |  24 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  79 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts        |  21 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                | 347 +++++---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts   |  59 ++
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts     |  33 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                | 100 ++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts         | 112 ++-
 arch/arm/boot/dts/sun9i-a80.dtsi                | 192 ++++-
 arch/arm/boot/dts/sunxi-common-regulators.dtsi  |  65 +-
 arch/arm/boot/dts/tegra124-nyan-big.dts         |   2 +
 arch/arm/boot/dts/tegra20.dtsi                  |  10 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |   2 +-
 arch/arm/boot/dts/tegra30.dtsi                  |   2 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi       |   2 +-
 arch/arm/boot/dts/vf-colibri.dtsi               |   3 +-
 arch/arm/boot/dts/vf500.dtsi                    |  23 +-
 arch/arm/boot/dts/vf610-twr.dts                 |   2 +-
 arch/arm/boot/dts/vfxxx.dtsi                    |  48 +-
 arch/arm/boot/dts/zynq-7000.dtsi                |  32 +-
 arch/arm/boot/dts/zynq-zc702.dts                | 224 +++++
 arch/arm/boot/dts/zynq-zc706.dts                | 194 +++++
 arch/arm/boot/dts/zynq-zed.dts                  |  15 +
 drivers/clk/samsung/clk-exynos5420.c            |  23 +-
 include/dt-bindings/clock/exynos5420.h          |   6 +
 include/dt-bindings/clock/r8a7790-clock.h       |   1 +
 include/dt-bindings/clock/r8a7791-clock.h       |   2 +
 include/dt-bindings/clock/r8a7794-clock.h       |  17 +
 include/dt-bindings/clock/rk3288-cru.h          |   4 +
 include/dt-bindings/clock/stih418-clks.h        |  34 +
 include/dt-bindings/dma/sun4i-a10.h             |  56 ++
 include/dt-bindings/pinctrl/omap.h              |   1 +
 include/dt-bindings/pinctrl/sun4i-a10.h         |  62 ++
 249 files changed, 14920 insertions(+), 2428 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/digicolor.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
 create mode 100644 Documentation/devicetree/bindings/clock/alphascale,acc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
 create mode 100644 Documentation/devicetree/bindings/sound/atmel_ac97c.txt
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi
 create mode 100644 arch/arm/boot/dts/am437x-idk-evm.dts
 create mode 100644 arch/arm/boot/dts/armada-385-db-ap.dts
 delete mode 100644 arch/arm/boot/dts/armada-385-rd.dts
 rename arch/arm/boot/dts/{armada-385-db.dts => armada-388-db.dts} (51%)
 create mode 100644 arch/arm/boot/dts/armada-388-gp.dts
 create mode 100644 arch/arm/boot/dts/armada-388-rd.dts
 create mode 100644 arch/arm/boot/dts/armada-388.dtsi
 create mode 100644 arch/arm/boot/dts/atlas7-evb.dts
 create mode 100644 arch/arm/boot/dts/atlas7.dtsi
 create mode 100644 arch/arm/boot/dts/axp209.dtsi
 create mode 100644 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
 create mode 100644 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
 create mode 100644 arch/arm/boot/dts/cx92755.dtsi
 create mode 100644 arch/arm/boot/dts/cx92755_equinox.dts
 create mode 100644 arch/arm/boot/dts/dm8168-evm.dts
 create mode 100644 arch/arm/boot/dts/dm816x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dm816x.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3.dts
 create mode 100644 arch/arm/boot/dts/hip01-ca9x2.dts
 create mode 100644 arch/arm/boot/dts/hip01.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-udoo.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-udoo.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sx-sabreauto.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-pogo_e02.dts
 delete mode 100644 arch/arm/boot/dts/marco-evb.dts
 delete mode 100644 arch/arm/boot/dts/marco.dtsi
 create mode 100644 arch/arm/boot/dts/rk3066a-rayeager.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-beta.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dtsi
 create mode 100644 arch/arm/boot/dts/stih407.dtsi
 create mode 100644 arch/arm/boot/dts/stih418-b2199.dts
 create mode 100644 arch/arm/boot/dts/stih418-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih418.dtsi
 create mode 100644 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-marsboard.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-mk802.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-mk802ii.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-mk802.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-cs908.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s.dtsi
 create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapro.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
 create mode 100644 include/dt-bindings/clock/stih418-clks.h
 create mode 100644 include/dt-bindings/dma/sun4i-a10.h
 create mode 100644 include/dt-bindings/pinctrl/sun4i-a10.h
