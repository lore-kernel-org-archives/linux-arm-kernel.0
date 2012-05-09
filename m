From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 18:12:33 +0100
Subject: Handling of modular boards
In-Reply-To: <CACRpkdb4LGXfJ72uODr841O7M4FGTYKa1X7y6ekeLUw9vaL=mw@mail.gmail.com>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205041934.08830.arnd@arndb.de>
 <CACRpkdb4LGXfJ72uODr841O7M4FGTYKa1X7y6ekeLUw9vaL=mw@mail.gmail.com>
Message-ID: <20120509171233.GL3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 02:26:54PM +0200, Linus Walleij wrote:
> On Fri, May 4, 2012 at 9:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > Thanks for getting the discussion started. I've seen the same issue come
> > up for arch/arm/mach-ux500/board-mop500*uib.c and for the beaglebone.
> > I'm sure there are many more, but we should make sure that everyone
> > of these can live with whatever we come up with.

> The same issue sort of comes up with any system that uses the idiom
> to have a few GPIO lines indicate in a binary code what version of the
> board we're dealing with and what devices are thus on it, right?

> We have this issue for the U9540 reference design and potentially
> on the Snowball as well.

Yes, I think that's basically the same problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/7674337d/attachment-0001.sig>
