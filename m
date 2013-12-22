From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 22 Dec 2013 12:40:08 -0500
Subject: [PATCHv8] rtc: Add support for Intersil ISL12057 I2C RTC chip
In-Reply-To: <8f0c072f0e5207d54a9f7ab0ba51b21b849abf69.1387491810.git.arno@natisbad.org>
References: <8f0c072f0e5207d54a9f7ab0ba51b21b849abf69.1387491810.git.arno@natisbad.org>
Message-ID: <20131222174008.GK2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:27:28PM +0100, Arnaud Ebalard wrote:
> Intersil ISL12057 is an I2C RTC chip also supporting two alarms. This
> patch only adds support for basic RTC functionalities (i.e. getting
> and setting time). Tests have been performed on NETGEAR ReadyNAS 102
> w/ startup/shutdown scripts, hwclock, ntpdate and openntpd.
> 
> Reviewed-by: Mark Brown <broonie@linaro.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
...
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  drivers/rtc/Kconfig                                |  11 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-isl12057.c                         | 310 +++++++++++++++++++++
>  5 files changed, 324 insertions(+)
>  create mode 100644 drivers/rtc/rtc-isl12057.c

Applied to mvebu/drivers.

thx,

Jason.
