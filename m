From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 29 Jan 2010 23:02:23 +0100
Subject: [PATCH v5] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <20100129213727.GB21364@pengutronix.de>
References: <1264799926.2975.3.camel@realization>
	<20100129213727.GB21364@pengutronix.de>
Message-ID: <1264802543.2975.17.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ven, 2010-01-29 at 22:37 +0100, Uwe Kleine-K?nig wrote:
> Hello Alberto,
> 
> On Fri, Jan 29, 2010 at 10:18:46PM +0100, Alberto Panizzo wrote:
> > The MXC family of Application Processors is shipped with a Keypad Port
> would you mind to do s/MXC/IMX/ in your patch?  Currently both are used
> but we (=Sascha and me) will try to deprecate MXC.

For sure! and for what I can say I approve this plan.

> 
> > + * >>Power management need to be implemented<<.
> s/need/needs/ (or alternatively do it :-)  and maybe s/<<\./.<</ ?

hehe, power management is the next part. What I wont is to put the 
device running before the next merge window if it is possible and
then present all my work on mx31_3ds.


> 
> > [...]
> > +
> > +	/* The matrix is stable only if no changes are detected after
> > +	 * MXC_KEYPAD_SCANS_FOR_STABILITY scans */
> unusual format of the comment.
> 
> 	/*
> 	 * ...
> 	 * ...
> 	 */
> 
> is the most found way in the kernel for multi-line comments.

Only a way to compress them..
> 
> > [...]
> > +MODULE_LICENSE("GPL v2");
> There is no space expected in the string passed to MODULE_LICENSE.

Thanks.

Alberto!
