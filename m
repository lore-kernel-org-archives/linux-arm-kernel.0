From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 24 Jan 2010 12:30:17 +0100
Subject: [PATCH] Alter name of U300 watchdog resource
In-Reply-To: <1264280677-23498-1-git-send-email-linus.walleij@stericsson.com>
References: <1264280677-23498-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100124113017.GB18782@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2010 at 10:04:37PM +0100, Linus Walleij wrote:
> This changes the bus name of the U300 watchdog from just "wdog"
> to "coh901327_wdog" which is used to match the corresponding
> driver. This makes the watchdog prope properly.
s/prope/probe/

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
