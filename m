From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jul 2012 12:12:47 +0100
Subject: [PATCH] spi-orion: add device tree binding
In-Reply-To: <20120723105945.GH18778@lunn.ch>
References: <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch>
 <20120722224241.GH4557@opensource.wolfsonmicro.com>
 <20120723072749.GA18778@lunn.ch>
 <20120723093747.GD4435@opensource.wolfsonmicro.com>
 <20120723100809.GC18778@lunn.ch>
 <20120723104333.GI4435@opensource.wolfsonmicro.com>
 <20120723105945.GH18778@lunn.ch>
Message-ID: <20120723111247.GN4435@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 12:59:45PM +0200, Andrew Lunn wrote:
> On Mon, Jul 23, 2012 at 11:43:34AM +0100, Mark Brown wrote:
> > On Mon, Jul 23, 2012 at 12:08:09PM +0200, Andrew Lunn wrote:

> > > +Optional properties:
> > > +- interrupts : Is currently not used.

> > Would it not be better to just omit this if it doesn't do anything and
> > doesn't have any semantics defined?

> I was specifically asked to include this, which is why it appeared in
> v2, not the first version. I forget who it was who asked for it, maybe
> Arnd Bergmann? I can dig through my email archive if you want to know.

If you're going to include it you should define some sematics for it.
You could define an optional "yohNg1ai" property too...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/d1e789c4/attachment.sig>
