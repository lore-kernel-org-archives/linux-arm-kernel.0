From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Feb 2010 10:43:18 +0100
Subject: [PATCH 1/3] gpiolib: make names array and its values const
In-Reply-To: <20100208093724.GA13019@jasper.tkos.co.il>
References: <20100203155558.GH11354@pengutronix.de>
	<1265620180-14150-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100208093724.GA13019@jasper.tkos.co.il>
Message-ID: <20100208094318.GE15255@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Mon, Feb 08, 2010 at 11:37:24AM +0200, Baruch Siach wrote:
> Hi Uwe,
> 
> On Mon, Feb 08, 2010 at 10:09:38AM +0100, Uwe Kleine-K?nig wrote:
> > gpiolib doesn't need to modify the names and I assume most initializers
> > use sting constants that shouldn't be modified anyhow.
> 
> s/sting/string/
Thanks, fixed in my tree.

BTW, you can get the updated series at

	git://git.pengutronix.de/git/ukl/linux-2.6.git gpiolib/names

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
