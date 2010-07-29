From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 29 Jul 2010 17:01:47 +0200
Subject: [PATCH v4] video/imxfb.c: allow usage without
	BACKLIGHT_CLASS_DEVICE
In-Reply-To: <1280413054-3046-1-git-send-email-eric@eukrea.com>
References: <4C5180E9.8070203@ru.mvista.com>
	<1280413054-3046-1-git-send-email-eric@eukrea.com>
Message-ID: <20100729150147.GA6331@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On Thu, Jul 29, 2010 at 04:17:34PM +0200, Eric B?nard wrote:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
> v4:	fix typo in CONFIG_FB_IMX_MODULE
> v3:	handle CONFIG_BACKLIGHT_CLASS_DEVICE=m & CONFIG_FB_IMX=y case as per
> 	suggested by Uwe
> v2:	handle CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE
looks ok to me now (though I didn't compile test).
(i.e. something like:
Reported-and-Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
)

Sascha, can you please take this.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
