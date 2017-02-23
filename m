From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Feb 2017 15:20:19 -0800
Subject: [GIT PULL 6/7] ARM: 64-bit DT updates for v4.11
In-Reply-To: <5992784.pTmbu8UWnt@wuerfel>
References: <8729461.VkrRdW7LzJ@wuerfel> <5992784.pTmbu8UWnt@wuerfel>
Message-ID: <3de0acea-bf24-b2c7-f86d-4d3934b20330@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2017 03:10 PM, Arnd Bergmann wrote:
> The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:
> 
>   Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt64
> 
> for you to fetch changes up to cbab31977008a9eb9eb241879befc2e20285740c:
> 
>   Merge tag 'mvebu-dt64-4.11-3' of git://git.infradead.org/linux-mvebu into next/dt64 (2017-02-09 16:20:23 +0100)
> 
> ----------------------------------------------------------------
> ARM: 64-bit DT updates for v4.11
> 
> ARM64 DT updates are fairly small this time, only two new SoCs and a handful
> of new machines get added, all of them similar to other hardware we already
> support.
> 
> New SoC:
>   - HiSilicon Kirin960/Hi3660 and HiKey960 development board
>   - NXP LS1012a with three reference boards
>     http://www.nxp.com/products/microcontrollers-and-processors/arm-processors/qoriq-layerscape-arm-processors/qoriq-layerscape-1012a-low-power-communication-processor:LS1012A
> 
> New development board:
>   - Banana Pi M64, based on Allwinner A64
>     http://www.banana-pi.org/m64.html
>   - SolidRun MACCHIATOBin based on Marvell Armada 8K
>     https://www.solid-run.com/marvell-armada-family/armada-8040-community-board/
>   - Broadcom BCM958712DxXMC NorthStar2 reference board (another one)
> 
> A lot of platforms improve support for existing machines by adding
> extra devices for which a binding and driver is availabe:
> 
> Allwinner: MMC, USB
> ARM Juno: Coresight, STM
> Broadcom: NS2 GICv2m irqchip and PCIe
> Marvell: Armada 3700 SPI, I2C, ethernet switch
> Mediatek: MT8173 thermal
> NXP i.MX: LS1046A thermal
> Qualcomm: coresight on MSM8916, HDMI, WCNSS, SCM
> Renesas: r8a779[56] thermal, powerdomain, ethernet, sound, pwm, can, can fd
> Rockchip: thermal, eDP, pinctrl enhancements
> Samsung: TM2 touchkey, Exynos5433 HDMI and power management improvements
> UniPhier: SD reset, eMMC controller
> ZTE: oppv2 cpufreq
> 

Hi Arnd,

I think the Amlogic patches are missing in these PRs for 4.11.

Neil
