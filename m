From: olof@lixom.net (Olof Johansson)
Date: Thu, 7 Jan 2016 06:31:22 +0100
Subject: [PATCH 1/2] ARM: versatile: select some defaults in defconfig
In-Reply-To: <1451984360-16885-1-git-send-email-linus.walleij@linaro.org>
References: <1451984360-16885-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160107053122.GG26875@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 09:59:20AM +0100, Linus Walleij wrote:
> This updates the Versatile defconfig to:
> - Use NO_HZ_IDLE and HIGH_RES_TIMERS
> - Enable the I2C driver
> - Enable the SPI driver
> - Enable the RTC driver for DS1338 as found on the Versatile
>   boards
> - Compile in the MMCI MMC driver, which is good if you
>   want to mount a root FS on the MMC card without having
>   to first load this module from an initramfs
> 
> Patch tested on the Versatile AB, QEMU for Versatile AB
> and QEMU for Versatile PB.
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly to wherever this goes
> for the next merge window.

Applied to next/defconfig. Thanks!


-Olof
