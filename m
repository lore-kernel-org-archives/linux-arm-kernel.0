From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Jul 2017 17:10:45 +0800
Subject: [PATCH v2] ARM: dts: imx6: RIoTboard provide gpio-line-names
In-Reply-To: <20170718054022.2867-1-o.rempel@pengutronix.de>
References: <20170718054022.2867-1-o.rempel@pengutronix.de>
Message-ID: <20170725091043.GJ20064@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 07:40:22AM +0200, Oleksij Rempel wrote:
> gpio-line-names may help to make work with GPIOs from user space easier.
> Following examples are provided with libgpiod
> https://github.com/brgl/libgpiod :
> |# Toggle a GPIO by name, then wait for the user to press ENTER.
> |$ gpioset --mode=wait `gpiofind "USR-LED-2"`=1
> |# Pause execution until a single event of any type occurs. Don't print
> |# anything. Find the line by name.
> |$ gpiomon --num-events=1 --silent `gpiofind "USR-IN"`
> 
> Used names was taken from RIoTboard schematics, version 1 (2013.12.07).
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks.
