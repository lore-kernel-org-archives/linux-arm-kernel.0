From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 06 May 2015 06:40:48 -0700
Subject: [PATCH] watchdog: imx2_wdt: also set wdog->timeout to new_timeout
In-Reply-To: <1430911079-23738-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1430911079-23738-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <554A19E0.20509@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2015 04:17 AM, Michael Grzeschik wrote:
> Commit faad5de0b104 ("watchdog: imx2_wdt: convert to watchdog core api")
> removes the custom ioctl function. The generic ioctl handler is not
> setting the wdog->timeout to the new_timeout but handing this preset
> value back to the userspace. This patch sets the new value in the
> drivers set_timeout function to fix that problem.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
