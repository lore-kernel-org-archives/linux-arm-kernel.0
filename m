From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 14 Mar 2013 07:01:30 -0700
Subject: [PATCH 04/10] drivers: hwmon: use module_platform_driver_probe()
In-Reply-To: <1363266691-15757-6-git-send-email-fabio.porcedda@gmail.com>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
 <1363266691-15757-6-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <20130314140130.GB16825@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 02:11:25PM +0100, Fabio Porcedda wrote:
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: lm-sensors at lm-sensors.org
> ---
>  drivers/hwmon/mc13783-adc.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
I have that one already queued for -next, submitted by Jingoo Han.

Thanks,
Guenter
