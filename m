From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Nov 2018 20:55:28 +0100
Subject: [PATCH] pwm: lpc18xx-sct: don't reconfigure PWM in .request and
 .free
In-Reply-To: <20181116100500.GC28631@ulmo>
References: <20181114115025.GC2620@ulmo>
 <20181116065208.3920-1-u.kleine-koenig@pengutronix.de>
 <20181116100500.GC28631@ulmo>
Message-ID: <20181119195528.elyioqz36be3ews3@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thierry,

On Fri, Nov 16, 2018 at 11:05:00AM +0100, Thierry Reding wrote:
> Applied, with some minor fixes to the commit message (pwm -> PWM,
> pwm_release -> pwm_put(), ...).

Thanks. I wonder though why the commit didn't make it into next yet.
Your for-next branch doesn't contain anything that's not already in
Linus Torvalds' tree. I assume this isn't on purpose and you just didn't
push your changes out?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
