From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jul 2012 09:17:36 +0200
Subject: [PATCH 20/25] gpio/gpio-omap: make platformdata used as
 *of_device_id.data const
In-Reply-To: <CAMQu2gw0fRa4kc2x-cm5ESGbo0tH30DnazaspHCnt6d9VjE9zg@mail.gmail.com>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-21-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAMQu2gw0fRa4kc2x-cm5ESGbo0tH30DnazaspHCnt6d9VjE9zg@mail.gmail.com>
Message-ID: <20120730071736.GH1528@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 29, 2012 at 11:27:57PM +0200, Shilimkar, Santosh wrote:
> On Mon, Jul 23, 2012 at 11:13 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> A line of description at least in the change log would be good otherwise
> patch is fine to me. Thanks.
I added:

	Since of_device_id.data is declared as a pointer to const data a
	few more consts can be added in this driver.

> Acked-by: Santosh.shilimkar<santosh.shilimkar@ti.com>
I assume your real name is "Santosh Shilimkar" and not
"Santosh.shilimkar", isn't it?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
