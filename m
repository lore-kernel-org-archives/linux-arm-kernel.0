From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 20 Mar 2014 21:51:45 +0100
Subject: [PATCH 09/62] ARM: efm32: allow uncompress debug output
In-Reply-To: <1395257399-359545-10-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-10-git-send-email-arnd@arndb.de>
Message-ID: <20140320205145.GE23076@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:29:06PM +0100, Arnd Bergmann wrote:
> efm32 has no mach/uncompress.h, but we can trivially use
> the fallback to the ll_debug code by just allowing this
> option in Kconfig.
> 
> Found during randconfig testing.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Uwe Kleine-K?nig <kernel@pengutronix.de>
I didn't test it (and in fact I cannot because there is too little RAM
to run a zImage on my board[1]) but the change looks good for a board
having more RAM, so

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

[1] maybe it would run long enough to see some output, but meh

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
