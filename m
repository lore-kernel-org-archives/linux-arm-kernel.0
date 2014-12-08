From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Dec 2014 14:22:11 +0100
Subject: [PATCH v3 0/4] spi: st: New driver for ST's SPI Controller
In-Reply-To: <1418043214-14324-1-git-send-email-lee.jones@linaro.org>
References: <1418043214-14324-1-git-send-email-lee.jones@linaro.org>
Message-ID: <11694915.sCOqLZA7N1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 December 2014 12:53:30 Lee Jones wrote:
> This is a new driver which controls the SPI component of ST's
> Synchronous Serial Controller (SSC).
> 

How does this related to the i2c driver for drivers/i2c/busses/i2c-st.c?
Could you have the same piece of hardware do one or the other mode
depending on pin configuration, or is each instance hardwired to
a particular mode?

Is there any code worth sharing between the two drivers?

	Arnd
