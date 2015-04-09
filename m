From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Apr 2015 13:00:34 +0200
Subject: [PATCH v2] pinctrl: make of_device_ids const
In-Reply-To: <CACRpkdbWm3TJc_oHdZccT73qUH7jwpu2Q4BR2gn2gz-tizn0wQ@mail.gmail.com>
References: <1427407231-2253-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdbWm3TJc_oHdZccT73qUH7jwpu2Q4BR2gn2gz-tizn0wQ@mail.gmail.com>
Message-ID: <20150409110034.GE9188@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 11:09:57AM +0200, Linus Walleij wrote:
> On Thu, Mar 26, 2015 at 11:00 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > of_device_ids (i.e. compatible strings and the respective data) are not
> > supposed to change at runtime. All functions working with of_device_ids
> > provided by <linux/of.h> work with const of_device_ids. This allows to
> > mark all struct of_device_id below drivers/pinctrl const, too.
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> I already have a patch like this from Fabian Frederick in my
> devel branch.
I applied my patch to today's next. The diffstat looks similar to the
original submission. Also

	git log linus/master..next/master --author=Fabian drivers/pinctrl

is empty?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
