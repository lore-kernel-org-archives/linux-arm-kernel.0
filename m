From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sat, 30 Jan 2010 12:27:21 +0100
Subject: [PATCH v5] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <20100129213727.GB21364@pengutronix.de>
References: <1264799926.2975.3.camel@realization>
	<20100129213727.GB21364@pengutronix.de>
Message-ID: <1264850841.2587.0.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ven, 2010-01-29 at 22:37 +0100, Uwe Kleine-K?nig wrote:
> > [...]
> > +MODULE_LICENSE("GPL v2");
> There is no space expected in the string passed to MODULE_LICENSE. 

in include/linux/module.h:

/*
 * The following license idents are currently accepted as indicating free
 * software modules
 *
 *	"GPL"				[GNU Public License v2 or later]
 *	"GPL v2"			[GNU Public License v2]
...
