From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 18 Apr 2012 19:33:45 +0200
Subject: [PATCH] ARM: davinci: mark spi_board_info arg to
 da8xx_register_spi as const
In-Reply-To: <4F8EEADF.60505@ti.com>
References: <1333138433-14637-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <4F8EEADF.60505@ti.com>
Message-ID: <20120418173345.GA20039@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Wed, Apr 18, 2012 at 09:55:03PM +0530, Sekhar Nori wrote:
> On 3/31/2012 1:43 AM, Uwe Kleine-K?nig wrote:
> > No further changes necessary
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Thanks for the patch. I extended this to include some other spi
> registration routines being used for DM355 and DM365. Here is the
> updated patch. Can you see if this is OK.
apart from being exchange-or-outlook-scrambled it looks ok. But actually
checking that the compiler doesn't yield any new warnings would be a
better check ...

> Also, please also Cc davinci-linux-open-source at linux.davincidsp.com on
> davinci patches.
I asked get_maintainer.pl who to Cc (and cut the list down a bit). Maybe
get_maintainer.pl doesn't include
davinci-linux-open-source at linux.davincidsp.com because it's
subscribers-only?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
