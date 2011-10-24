From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 24 Oct 2011 15:02:44 +0200
Subject: [PATCH 0/2] ARM: Samsung: Add basic device tree support for
	Exynos4 boards
In-Reply-To: <1318342396-26178-1-git-send-email-thomas.abraham@linaro.org>
References: <1318342396-26178-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4EA561F4.5010606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/11 16:13, Thomas Abraham wrote:
> This patchset adds a new basic device tree enabled machine/board file which is
> based on the Samsung's Exynos4 family of SoC's. Also included in this patchset is the
> dts file for Exynos4210 SoC, Samsung's SMDKV310 board and Insignal's Origen board.
>
> The Exynos4210 dts file includes support for IRQ, GPIO, WDT, RTC, UART, SDHCI, Keypad,
> DMA and I2C controllers. As device tree coverage for Exynos4210 increases, additional
> device nodes to represent the controllers should be added.
>
> The device tree enabled machine file enables boot on two boards based on the
> Exynos4210 SoC. This provides a starting point to add additional device tree support
> on these boards, migrate other existing Exynos4 based boards to use device tree
> and enable device tree based boot on new upcoming boards.
>
> This patchset has been tested on the following tree:
>    https://github.com/kgene/linux-samsung.git   branch: for-next
>
> Thomas Abraham (2):
>    ARM: Samsung: Add Exynos4 device tree enabled board file
>    ARM: dts: Add intial dts file for Exynos4210 SoC, SMDKV310 and Origen board
>
>   .../devicetree/bindings/arm/insignal-boards.txt    |    8 +
>   .../devicetree/bindings/arm/samsung-boards.txt     |    8 +
>   arch/arm/boot/dts/exynos4210-origen.dts            |  137 +++++++
>   arch/arm/boot/dts/exynos4210-smdkv310.dts          |  182 +++++++++
>   arch/arm/boot/dts/exynos4210.dtsi                  |  403 ++++++++++++++++++++
>   arch/arm/mach-exynos4/Kconfig                      |   14 +
>   arch/arm/mach-exynos4/Makefile                     |    2 +
>   arch/arm/mach-exynos4/mach-exynos4-dt.c            |   85 ++++
>   8 files changed, 839 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/insignal-boards.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/samsung-boards.txt
>   create mode 100644 arch/arm/boot/dts/exynos4210-origen.dts
>   create mode 100644 arch/arm/boot/dts/exynos4210-smdkv310.dts
>   create mode 100644 arch/arm/boot/dts/exynos4210.dtsi
>   create mode 100644 arch/arm/mach-exynos4/mach-exynos4-dt.c

Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
