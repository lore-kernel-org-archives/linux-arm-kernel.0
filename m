From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 26 Aug 2016 18:32:36 +0200
Subject: [PATCH v2 6/7] arm64: dts: exynos: Add dts file for
 Exynos5433-based TM2 board
In-Reply-To: <1472046551-703-7-git-send-email-cw00.choi@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-7-git-send-email-cw00.choi@samsung.com>
Message-ID: <20160826163236.GC15511@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 10:49:10PM +0900, Chanwoo Choi wrote:
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
> - MSHC (Mobile Storae Host Controller) for eMMC device

Not fixed. Mobile Storage.

Everything else looks fine, so fix above only if you are going to resend
everything. If there won't be resend, I can fix it when applying.

For the record:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
