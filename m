From: olof@lixom.net (Olof Johansson)
Date: Wed, 25 Jul 2018 23:57:04 -0700
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.19
In-Reply-To: <20180724131536.iompsqlrpjsvf5uy@flea>
References: <20180724131536.iompsqlrpjsvf5uy@flea>
Message-ID: <20180726065704.r7gvelee24mdyiap@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 03:15:36PM +0200, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Please pull the following changes for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.19
> 
> for you to fetch changes up to ecbd611882a18cc5e720e752cae92d1198b198ec:
> 
>   arm64: allwinner: h6: enable MMC0/2 on Pine H64 (2018-07-19 16:50:33 +0200)
> 
> ----------------------------------------------------------------
> Allwinner arm64 DT changes for 4.19
> 
> Some interesting changes, especially:
> 
>   - MMC support for the H6
>   - PMIC support for the PineH64
>   - HDMI simplefb support for the A64
>   - PWM support for the A64
>   - New board: Pinebook, Amarula A64-Relic
> 
> ----------------------------------------------------------------
> Andre Przywara (1):
>       arm64: dts: allwinner: a64: Add PWM controllers
> 
> Chen-Yu Tsai (2):
>       arm64: dts: allwinner: h6: Add LED device nodes for Pine H64
>       arm64: dts: allwinner: h6: Use macros for R_CCU clock and reset indices
> 
> Corentin Labbe (1):
>       arm64: dts: allwinner: a64: Remove unused address-cells/size-cells of dwmac-sun8i
> 
> Emmanuel Vadot (3):
>       arm64: dts: allwinner: sun50i: a64: Add spi flash node for sopine
>       arm64: dts: allwinner: sun50i: h5: Add spi flash node for OrangePi PC2
>       arm64: allwinner: a64-sopine: Add cd-gpios to mmc0 node
> 
> Icenowy Zheng (12):
>       arm64: dts: allwinner: a64: add R_I2C controller
>       arm64: dts: allwinner: add support for Pinebook
>       arm64: dts: allwinner: a64: add SRAM controller device tree node
>       arm64: allwinner: a64: change TERES-I DLDO3's name to start with "vdd"
>       arm64: allwinner: a64: allow laptops to wake up from lid
>       arm64: dts: allwinner: a64: add necessary device tree nodes for DE2 CCU
>       arm64: dts: allwinner: a64: add device tree node for HDMI simplefb
>       arm64: dts: allwinner: a64: add HDMI regulator to all DTs' simplefb_hdmi
>       arm64: dts: allwinner: h6: enable AXP805 PMIC on Pine H64
>       dt-binding: mmc: sunxi: add H6 compatible (with A64 fallback)
>       arm64: allwinner: h6: add device tree nodes for MMC controllers
>       arm64: allwinner: h6: enable MMC0/2 on Pine H64
> 
> Jagan Teki (3):
>       arm64: allwinner: a64: Add Amarula A64-Relic initial support
>       arm64: allwinner: a64: Add RTC clock to phandle 32kHz external oscillator
>       arm64: allwinner: a64-amarula-relic: Enable AP6330 WiFi support

A bit more consistency here would be nice (some have dts, some don't).


Anyway, merged. Thanks.


-Olof
