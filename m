From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 3 Nov 2016 22:10:53 +0200
Subject: [PATCH v3 4/5] arm64: dts: exynos: Add dts file for
 Exynos5433-based TM2 board
In-Reply-To: <1478155149-28527-5-git-send-email-cw00.choi@samsung.com>
References: <1478155149-28527-1-git-send-email-cw00.choi@samsung.com>
 <1478155149-28527-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <20161103201053.GB9379@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:39:08PM +0900, Chanwoo Choi wrote:
> This patch adds the Device Tree source for Exynos5433-based Samsung TM2 board.
> This board fully support the all things for mobile target.
> 
> This patch supports the following devices:
> 1. basic SoC
> - Initial booting for Samsung Exynos5433 SoC
> - DRAM LPDDR3 (3GB)
> - eMMC (32GB)
> - ARM architecture timer
> 
> 2. power management devices
> - Sasmung S2MPS13 PMIC for the power supply
> - CPUFREQ for big.LITTLE cores
> - TMU for big.LITTLE cores and GPU
> - ADC with thermistor to measure the temperature of AP/Battery/Charger
> - Maxim MAX77843 Interface PMIC (MUIC/Haptic/Regulator)
> 
> 3. sound devices
> - I2S for sound bus
> - LPASS for sound power control
> - Wolfson WM5110 for sound codec
> - Maxim MAX98504 for speaker amplifier
> - TM2 ASoC Machine device driver node
> 
> 3. display devices
> - DECON, DSI and MIC for the panel output
> 
> 4. usb devices
> - USB 3.0 DRD (Dual Role Device)
> - USB 3.0 Host controller
> 
> 5. storage devices
> - MSHC (Mobile Storage Host Controller) for eMMC device
> 
> 6. misc devices
> - gpio-keys (power, volume up/down, home key)
> - PWM (Pulse Width Modulation Timer)
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> Signed-off-by: Ingi kim <ingi2.kim@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |   1 +
>  arch/arm64/boot/dts/exynos/Makefile                |   4 +-
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 974 +++++++++++++++++++++
>  3 files changed, 978 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts

Thanks, applied.

Best regards,
Krzysztof
