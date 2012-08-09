From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Aug 2012 18:27:42 +0200
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <1344529412-18053-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1344529412-18053-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120809162742.GG25520@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> +  pull-up for this pin. Please refer to imx53 datasheet for the valid pad
argh, I forgot to fix that (ie. s/53/35/). I won't resend just for that.
Linus, assuming you intend to take the patch now, can you fix it up
while commiting please?

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
