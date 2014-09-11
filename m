From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 11 Sep 2014 15:15:18 +0200
Subject: [PATCH] pinctrl: make of_device_ids const
In-Reply-To: <CACRpkda1h_GOYh6dJeJJF5pnwLmn5UYCtk-v=b0k56zKy9m8=A@mail.gmail.com>
References: <1410380437-17960-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkda1h_GOYh6dJeJJF5pnwLmn5UYCtk-v=b0k56zKy9m8=A@mail.gmail.com>
Message-ID: <20140911131518.GK3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 03:07:55PM +0200, Linus Walleij wrote:
> On Wed, Sep 10, 2014 at 10:20 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > of_device_ids (i.e. compatible strings and the respective data) are not
> > supposed to change at runtime. All functions working with of_device_ids
> > provided by <linux/of.h> work with const of_device_ids. This allows to
> > mark all struct of_device_id below drivers/pinctrl const, too.
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Sorry! This low-hanging fruit was already picked by Kiran by an
I wouldn't call it low-hanging fruit because verification that nothing
breaks is manual work. :-\

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
