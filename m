From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 3 Nov 2009 20:06:16 +0100
Subject: [PATCH 1/2] [ARM] i2c/pxa: remove unused macro
In-Reply-To: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091103190616.GB3312@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2009-11-03 20:03:19, Uwe Kleine-K?nig wrote:
> Commit
> 
> 	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)
> 
> removed all uses of eedbg, so the definition can go, too.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Eric Miao <eric.miao@marvell.com>
> Cc: Roel Kluin <roel.kluin@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
