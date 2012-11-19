From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 19 Nov 2012 15:45:24 +0100
Subject: [PATCH 0/5] ARM: dts: exynos4210-trats: Device tree extension
Message-ID: <1353336329-20818-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series extends device tree support for Trats board.

It adds support for pinctrl, GPIO keys and touchscreen to Trats dts file.

Tested on Trats board.

Depends on:
[PATCH] i2c: i2c-s3c2410: Add support for pinctrl
[PATCH v2 0/2] mmc: host: sdhci-s3c: Add support for pinctrl interface

Tomasz Figa (5):
  ARM: dts: exynos4210-trats: Update for pinctrl-samsung driver
  ARM: dts: exynos4210-trats: Add nodes for GPIO keys available on
    Trats
  ARM: dts: exynos4210-trats: Add node for i2c3 bus
  ARM: dts: exynos4210-trats: Add node for touchscreen voltage
    regulator
  ARM: dts: exynos4210-trats: Add node for touchscreen

 arch/arm/boot/dts/exynos4210-trats.dts | 86 +++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 16 deletions(-)

-- 
1.8.0
