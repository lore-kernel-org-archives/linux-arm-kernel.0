From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 28 Dec 2013 16:25:19 -0500
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <20131228205928.GB19850@lunn.ch>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
 <20131228170114.GH19878@titan.lakedaemon.net>
 <20131228205928.GB19850@lunn.ch>
Message-ID: <20131228212519.GI19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Sat, Dec 28, 2013 at 09:59:28PM +0100, Andrew Lunn wrote:
> On Sat, Dec 28, 2013 at 12:01:14PM -0500, Jason Cooper wrote:
> > On Sat, Dec 28, 2013 at 05:12:11PM +0100, Andrew Lunn wrote:
...
> > > +	ocp at f1000000 {
> > 
> > I plan on going though and sorting the nodes under the ocp bus for all
> > the dts files during the next cycle.  Would you mind sorting these so we
> > have one less to worry about?
> 
> Sure. Sort on what? Address, alphabetic on node name?

address please.

...
> > > +		};
> > > +
> > > +		serial at 12000 {
> > > +			/* Internal on test pins, 3.3v TTL */
> > 
> > Do you have a pointer to a pin layout?
> 
> Yes, i can add a URL to an Excito forum page. They are friendly about
> this, document it themselves.

ok, considering the transience of web pages, perhaps a little ascii art?
Not a show stopper, just if you're inclined.

> > > +		programming_led {
> > > +			label = "bubba3:green:programming";
> > > +			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> > > +			linux,default-trigger = "default-off";
> > 
> > Perhaps we can use 'default-state = "off";' here to avoid the
> > linux-specific property?
> 
> Sure.
> 
> v2 in the next day or two.

thx,

Jason.
