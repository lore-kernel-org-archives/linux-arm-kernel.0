From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 20 Jan 2013 21:13:36 +0100
Subject: [PATCH] power: reset: qnap-poweroff: Fix License String
In-Reply-To: <1357668926-20598-1-git-send-email-andrew@lunn.ch>
References: <20130106215509.GD26928@lizard.sbx05280.losalca.wayport.net>
 <1357668926-20598-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130120201336.GO8668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 07:15:26PM +0100, Andrew Lunn wrote:
> GPLv2+ is not a valid license string. Replace it with one that is.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/power/reset/qnap-poweroff.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
> index ca0b476..8af772b 100644
> --- a/drivers/power/reset/qnap-poweroff.c
> +++ b/drivers/power/reset/qnap-poweroff.c
> @@ -121,4 +121,4 @@ module_platform_driver(qnap_power_off_driver);
>  
>  MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
>  MODULE_DESCRIPTION("QNAP Power off driver");
> -MODULE_LICENSE("GPLv2+");
> +MODULE_LICENSE("GPL v2");
This change is wrong.

According to include/linux/module.h "GPL v2" means exactly that: version
2. As the file specifies v2 or later in the header you have to use "GPL"
which means v2 or later.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
