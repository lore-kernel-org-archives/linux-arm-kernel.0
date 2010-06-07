From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Jun 2010 16:56:33 +0200
Subject: [PATCH v2] pxa/z2: Add regulator support
In-Reply-To: <20100607113910.GC5993@sirena.org.uk>
References: <1275883143-3512-1-git-send-email-marek.vasut@gmail.com>
	<20100607113910.GC5993@sirena.org.uk>
Message-ID: <201006071656.33063.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 7. ?ervna 2010 13:39:10 Mark Brown napsal(a):
> On Mon, Jun 07, 2010 at 05:59:03AM +0200, Marek Vasut wrote:
> > +	}, {
> > +		.constraints = {
> > +			.name		= "LDO1",
> > +			.min_uV		= 1000000,
> > +			.max_uV		= 3150000,
> > +			.always_on	= 1,
> > +		},
> > +	}, {
> > +		.constraints = {
> > +			.name		= "LDO2",
> > +			.min_uV		= 1050000,
> > +			.max_uV		= 3300000,
> > +			.always_on	= 1,
> > +		},
> > +	}
> 
> Are you *sure* that the voltages for these regulators can be varied this
> much (especailly given that there are no consumers set up)?

These are not connected so I believe it doesn't matter. Though I'm still 
slightly unfamiliar with the regulator API. Here I should have CCed you, sorry.

Is this the correct way or is there some other way to just shut these off ?

Cheers
