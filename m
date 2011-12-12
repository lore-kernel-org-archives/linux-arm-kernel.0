From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 12 Dec 2011 18:08:56 +0100
Subject: [PATCH V3] mfd: Fixed unconditional reset of the ADC reading
 enable bits
In-Reply-To: <20111212171143.GP13952@sortiz-mobl>
References: <1322564943-17872-1-git-send-email-robin@protonic.nl>
 <20111212171143.GP13952@sortiz-mobl>
Message-ID: <20111212170856.GB4585@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 06:11:43PM +0100, Samuel Ortiz wrote:
> Hi Robin,
> 
> On Tue, Nov 29, 2011 at 12:09:03PM +0100, Robin van der Gracht wrote:
> > When the ADC is being prepared for a single or multiple channel reading,
> > the adc0 register is reconfigured without taking the lithium cell, charge
> > current and battery current reading enable bits into account. Which results
> > in clearing the bits.
> 
> Patch applied, thanks. Uwe, should I add your Acked-by ?
you can.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
