From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 21 Jun 2010 07:09:57 +0200
Subject: gpiolib and sleeping gpios
In-Reply-To: <887171.45295.qm@web180307.mail.gq1.yahoo.com>
References: <4C1E88AE.5070808@bluewatersys.com>
	<887171.45295.qm@web180307.mail.gq1.yahoo.com>
Message-ID: <20100621050957.GA23094@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 20, 2010 at 07:40:46PM -0700, David Brownell wrote:
> > > And they will trigger runtime warnings, and
> > > thus eventually get fixed.
> > \
> > ? }
> > 
> > ? err = gpio_request(some_gpio, "some_gpio",
> >           GPIOF_NO_SLEEP);
> 
> 
> NAK ... keep it simple.  Such flags are
> clearly not necessary...
> 
> I understand that some folk are bothered
> by concepts/frameworks that seem "too simple"
> and thus want to complexify them.  In this
> case I am in a position to help avoid that.
> Complexity is not a virtue.
I'm against such an additional flag, too.  But I still think merging
gpio_get_value and gpio_get_value_cansleep is nice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
