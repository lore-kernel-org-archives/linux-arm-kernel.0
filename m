From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jul 2012 17:43:13 +0000
Subject: [PATCH] spi-orion: add device tree binding
In-Reply-To: <20120723111247.GN4435@opensource.wolfsonmicro.com>
References: <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120723105945.GH18778@lunn.ch>
 <20120723111247.GN4435@opensource.wolfsonmicro.com>
Message-ID: <201207231743.14096.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 July 2012, Mark Brown wrote:
> On Mon, Jul 23, 2012 at 12:59:45PM +0200, Andrew Lunn wrote:
> > On Mon, Jul 23, 2012 at 11:43:34AM +0100, Mark Brown wrote:
> > > On Mon, Jul 23, 2012 at 12:08:09PM +0200, Andrew Lunn wrote:
> 
> > > > +Optional properties:
> > > > +- interrupts : Is currently not used.
> 
> > > Would it not be better to just omit this if it doesn't do anything and
> > > doesn't have any semantics defined?
> 
> > I was specifically asked to include this, which is why it appeared in
> > v2, not the first version. I forget who it was who asked for it, maybe
> > Arnd Bergmann? I can dig through my email archive if you want to know.
> 
> If you're going to include it you should define some sematics for it.
> You could define an optional "yohNg1ai" property too...

Agreed. I'm rather sure I did not ask for an unused property to be
documented. However, the documentation should definitely match the
example and the what kinds of properties are used in the device tree.

If the device has an interrupt that is not used by Linux, I would
document what the interrupt is for.

	Arnd
