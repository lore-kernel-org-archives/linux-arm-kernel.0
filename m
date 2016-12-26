From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 26 Dec 2016 12:12:35 -0800
Subject: [PATCH v2] watchdog: constify watchdog_info structures
In-Reply-To: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
References: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
Message-ID: <4e7daea3-19d1-a8a8-c15a-9e3f5785d817@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/26/16 ? 09:05, Bhumika Goyal a ?crit :
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> Changes in v2:
>   * Drop "drivers:" from the subject line.
>   * Remove the file size details.
> 
>  drivers/watchdog/bcm7038_wdt.c   | 2 +-

> diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
> index e238df4..37c6a49 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
> @@ -101,7 +101,7 @@ static unsigned int bcm7038_wdt_get_timeleft(struct watchdog_device *wdog)
>  	return time_left / wdt->rate;
>  }

For BCM7038 WDT:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
