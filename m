From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 00:04:21 +0200
Subject: [PATCH] arm64: defconfig: enable HW random as module
In-Reply-To: <20160903001301.32289-1-khilman@baylibre.com>
References: <20160903001301.32289-1-khilman@baylibre.com>
Message-ID: <5985387.ppWVMBzPQU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 2, 2016 5:13:00 PM CEST Kevin Hilman wrote:
> drivers/char/hw_random/Kconfig has 'default m', so
> simply removing this entry from the defconfig will
> enable building HW random drivers as modules.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---

Applied four patches to next/arm64:

699189c arm64: defconfig: enable meson I2C
5a9a9cf arm64: defconfig: enable meson SPI as module
19b9869 arm64: defconfig: enable meson WDT as modules
5012a09 arm64: defconfig: enable HW random as module

Thanks,

	Arnd
