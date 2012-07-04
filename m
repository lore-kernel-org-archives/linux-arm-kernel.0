From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Jul 2012 11:43:04 +0000
Subject: [PATCH 1/2] ARM: PRIMA2: add of_dev_auxdata table for I2C, SPI,
 UART and PINCTRL
In-Reply-To: <1341373400-15763-1-git-send-email-Barry.Song@csr.com>
References: <1341373400-15763-1-git-send-email-Barry.Song@csr.com>
Message-ID: <201207041143.04942.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 July 2012, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> This patch adds lookup table for attaching a specific name and platform_data
> pointer to devices like i2c, spi, uart and pinctrl as they get created by
> of_platform_populate().  Ideally this table would not exist.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Hi Barry,

I don't understand. Which subsystem relies on the short names here?

If it's about the pinctrl and clock parts, can't you just uses the
generate names like "b0050000.uart" directly?

	Arnd
