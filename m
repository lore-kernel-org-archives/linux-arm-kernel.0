From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 26 Nov 2014 16:59:20 +0100
Subject: [PATCH v2 4/5] i2c: davinci: use bus recovery infrastructure
In-Reply-To: <1417010393-30598-5-git-send-email-grygorii.strashko@ti.com>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-5-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20141126155920.GM4431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On Wed, Nov 26, 2014 at 03:59:52PM +0200, Grygorii Strashko wrote:
> This patch converts Davinci I2C driver to use I2C bus recovery
> infrastructure, introduced by commit 5f9296ba21b3 ("i2c: Add
> bus recovery infrastructure").
> 
> The i2c_bus_recovery_info is configured for Davinci I2C adapter
> only in case if scl_pin is provided in platform data at least.
My German feeling for English tells me:
s/if//; s/at least//;

With that changed you can add my Ack.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
