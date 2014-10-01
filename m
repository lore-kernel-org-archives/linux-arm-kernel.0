From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Oct 2014 16:39:30 +0200
Subject: [GIT PULL] qcom defconfig changes for v3.18
In-Reply-To: <676B1050-4098-4E8C-A60D-07D86C3BF289@codeaurora.org>
References: <676B1050-4098-4E8C-A60D-07D86C3BF289@codeaurora.org>
Message-ID: <201410011639.31055.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014, Kumar Gala wrote:
> Qualcomm ARM Based defconfig Updates for v3.18
> 
> * General defconfig update to match upstream changes
> * Enable IPQ806x & APQ8084 clk support
> * Enable pinctrl on MSM8960 & APQ8084
> * Enable CPU_IDLE to get basic wfi support
> * Enable SPI NOR and MTD M25P80 support (used on AP148 board)
> * Enable SATA PHY support on IPQ806x and APQ8064
> * Enable Fixed regulator and ARM MMCI support (mmc support on APQ8064)

This seems harmless, so I've pulled it into next/defconfig now.
Sorry for the delay, I basically stopped pulling anything that only
came in last week when it seemed that we'd have merge window opening
already.

	Arnd
