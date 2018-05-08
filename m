From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 May 2018 12:51:31 +0200
Subject: [PATCH v3 3/3] tty: implement led triggers
In-Reply-To: <20180508100851.GY2285@localhost>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
 <20180508100851.GY2285@localhost>
Message-ID: <20180508105131.agz7u3q42gy7mrxy@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2018 at 12:08:51PM +0200, Johan Hovold wrote:
> On Tue, May 08, 2018 at 12:05:43PM +0200, Uwe Kleine-K?nig wrote:
> > The rx trigger fires when data is pushed to the ldisc by the driver. This
> > is a bit later than the actual receiving of data but has the nice benefit
> > that it doesn't need adaption for each driver and isn't in the hot path.
> > 
> > Similarly the tx trigger fires when data was copied from userspace and is
> > given to the ldisc.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx25-logitech-baby.dts | 192 ++++++++++++++++++++++
> 
> Looks like you included more than intended in this patch.

Right, this doesn't belong here. Feel free to assume I didn't include it
in the patch and comment the rest :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
