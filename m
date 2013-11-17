From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 16 Nov 2013 18:19:15 -0800
Subject: Fwd: [PATCH 2/8] watchdog: davinci: use davinci_wdt_device
 structure to hold device data
In-Reply-To: <527A2888.5030604@ti.com>
References: <1383680783-12114-3-git-send-email-ivan.khoronzhuk@ti.com>
 <527A2888.5030604@ti.com>
Message-ID: <528827A3.6050108@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2013 03:31 AM, ivan.khoronzhuk wrote:
> Some SoCs, like Keystone 2, can support more than one WDT and each
> watchdog device has to use it's own base address, clock source,
> wdd device, so add new davinci_wdt_device structure to hold device
> data.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Reviewed-by: Guenter roeck <linux@roeck-us.net>
