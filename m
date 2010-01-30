From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 30 Jan 2010 12:56:53 +0100
Subject: [PATCH v5] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <1264850841.2587.0.camel@realization>
References: <1264799926.2975.3.camel@realization>
	<20100129213727.GB21364@pengutronix.de>
	<1264850841.2587.0.camel@realization>
Message-ID: <20100130115653.GA12444@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 30, 2010 at 12:27:21PM +0100, Alberto Panizzo wrote:
> On ven, 2010-01-29 at 22:37 +0100, Uwe Kleine-K?nig wrote:
> > > [...]
> > > +MODULE_LICENSE("GPL v2");
> > There is no space expected in the string passed to MODULE_LICENSE. 
> 
> in include/linux/module.h:
> 
> /*
>  * The following license idents are currently accepted as indicating free
>  * software modules
>  *
>  *	"GPL"				[GNU Public License v2 or later]
>  *	"GPL v2"			[GNU Public License v2]
> ...
Hmmmm, then sorry.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
