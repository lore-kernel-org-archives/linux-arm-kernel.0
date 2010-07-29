From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 29 Jul 2010 07:16:48 +0200
Subject: [PATCH 3/3] imxfb: add pwmr controlled backlight support
In-Reply-To: <1279285747-7860-3-git-send-email-eric@eukrea.com>
References: <1279285747-7860-1-git-send-email-eric@eukrea.com>
	<1279285747-7860-2-git-send-email-eric@eukrea.com>
	<1279285747-7860-3-git-send-email-eric@eukrea.com>
Message-ID: <20100729051647.GA11268@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
> v2 : updated to use backlight infrastructure
this should have a dependency on CONFIG_BACKLIGHT_CLASS_DEVICE.  As
Sascha already took your patch you can just try to build mx27_defconfig
on his for-rmk branch :-|

Instead of a dependency I would prefer to have imxfb usable without
CONFIG_BACKLIGHT_CLASS_DEVICE.  From a quick look there are drivers that
have that.  (I checked drivers/video/sa1100fb.c +
drivers/video/backlight/locomolcd.c.)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
