From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 01 Dec 2014 01:06:51 +0100
Subject: [PATCH v1] ARM: dts: rockchip: Update LEDs to work with the last
 leds-gpio driver on radxarock
In-Reply-To: <1416759575-774-1-git-send-email-romain.perier@gmail.com>
References: <1416759575-774-1-git-send-email-romain.perier@gmail.com>
Message-ID: <2199937.lXpYYkmmQM@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 23. November 2014, 16:19:35 schrieb Romain Perier:
> The leds-gpio driver recently switched to the device property API. The
> device_node name is no longer retrieved if the "label" devicetree property
> is not found. In this case the driver tries to create entries with (null)
> name in /sys/class/leds, which is wrong and generates backtrace as several
> gpio_leds have the same name. Also renamed subnode "yellow" to "blue" to
> match the last schematics updates.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

applied to my dts branch
