From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Jul 2014 20:42:37 +0200
Subject: [PATCH v2] i2c: efm32: correct namespacing of location property
In-Reply-To: <20140717134000.GK2740@katana>
References: <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1405068614-14279-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140717134000.GK2740@katana>
Message-ID: <20140717184237.GX11056@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 03:40:00PM +0200, Wolfram Sang wrote:
> On Fri, Jul 11, 2014 at 10:50:14AM +0200, Uwe Kleine-K?nig wrote:
> > Olof Johansson pointed out that usually the company name is picked as
> > namespace prefix to specific properties. So expect "energymicro,location"
> > but fall back to the previously introduced name "efm32,location".
> > 
> > Cc: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Applied to for-next, thanks! If you think this is better suited in
> for-current, let me know.
I'm not in a hurry. If you take it it's fine for me.

(BTW, I'm not sure i fI understand your branch naming. for-next means
"targeting the next merge window" and for-current means "targeting the
next release"? So for-next currently means 3.17-rc1?)

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
