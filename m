From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 6 Apr 2015 18:49:00 -0700
Subject: [PATCH 02/13] thermal: trivial: fix typo in comment
In-Reply-To: <1427385240-6086-3-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150407014859.GC4648@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 04:53:49PM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 0e4ad7c..c735ac4c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -402,7 +402,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>  }
>  
>  /**
> - * thermal_zone_get_temp() - returns its the temperature of thermal zone
> + * thermal_zone_get_temp() - returns the temperature of a thermal zone
>   * @tz: a valid pointer to a struct thermal_zone_device
>   * @temp: a valid pointer to where to store the resulting temperature.
>   *
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/c7d23f2a/attachment.sig>
