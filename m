From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 27 Nov 2018 09:35:23 +0100
Subject: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
In-Reply-To: <20181127075226.qo3mv3o6etqdjaop@flea>
References: <20181125161859.GA5277@arx-s1>
 <20181127075226.qo3mv3o6etqdjaop@flea>
Message-ID: <20181127083523.pciie2gyaplrwiey@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 27, 2018 at 08:52:26AM +0100, Maxime Ripard wrote:
> On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> > +  - clocks: From common clock binding, handle to the parent clock.
> > +  - clock-names: Must contain the clock names described just above.
> 
> [...]
> 
> You seem to have used mux-0 and mux-1 for the clock names. I guess we
> don't have to use a name there, we can simply use the position to find
> out (as long as it's documented in the binding)

I also wondered if the driver relies on the fact that the second clock
is the faster running one. Is this sensible?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
