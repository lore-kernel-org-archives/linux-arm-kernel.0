From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 19 Jun 2015 13:01:01 +0000
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <1434716194.17448.28.camel@x60s>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <1434446447.4785.7.camel@dolka.fr>
 <1434593555.13334.14.camel@dolka.fr> <558278A8.2050406@arm.com>
 <1434677895.4767.11.camel@dolka.fr> <5583DD23.90505@arm.com>
 <1434716194.17448.28.camel@x60s>
Message-ID: <20150619130101.GD2936@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benjamin,

On Fri, Jun 19, 2015 at 02:16:34PM +0200, Benjamin Cama wrote:
> Le vendredi 19 juin 2015 ?? 10:13 +0100, Marc Zyngier a ??crit :
> > On 19/06/15 02:38, Benjamin Cama wrote:
...
> > > I read quite a bit about all this virtual/hardware IRQ stuff, and the
> > > irq domains, interesting. I see that orion5x seems to be one of the
> > > last platforms not using it (appart from DT-converted boards); is it a
> > > bad sign about its durability????
> > 
> > No, we have platforms that will most probably never be converted to DT,
> > and they are very far from rotting in the tree.
> 
> Nice to know. One of the reasons for converting my board to DT was fear
> that it may one day be mandatory. Is there any particular reason for
> keeping some boards non-DT while still being maintained?

If folks are using the sub-arch and interested in maintaining them, they
stick around.  mach-orion5x/ is a wierd case because there aren't many
users.  The mvebu folks have put a lot of work into supporting /
converting the legacy platforms (kirkwood, dove).  Thomas did most of
the work converting orion5x, but there simply aren't many users to test.
So it's in a half-converted state.

iow, we're glad to see you contributing patches for orion5x.  ;-)

thx,

Jason.
