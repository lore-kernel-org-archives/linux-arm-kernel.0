From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 14:20:46 +0200
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <1400278842.2647.62.camel@deadeye.wl.decadent.org.uk>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <20140516184205.GL27822@titan.lakedaemon.net>
 <1400278842.2647.62.camel@deadeye.wl.decadent.org.uk>
Message-ID: <4931877.zNfKfvcgox@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 May 2014 23:20:42 Ben Hutchings wrote:
> On Fri, 2014-05-16 at 14:42 -0400, Jason Cooper wrote:
> > On Fri, May 16, 2014 at 07:31:51PM +0100, Ben Hutchings wrote:
> > > Our 'legacy' (which I take to mean pre-v7) configurations are now
> > > kirkwood, mv78xx0, orion5x (all about to converge to mvebu) and
> > > versatile.
> > 
> > I'm not familiar with versatile, the others I've seen a few times. 
> 
> Versatile is one of ARM's own development boards, but more importantly
> it's something QEMU can emulate.

We should really have this in multiplatform soon, I think the last issue
for versatile is common clock support, but Linus Walleij may have more
details about what remains here.

We should also make it possible to enable ARCH_VIRT for pre-ARMv7 to
get qemu users to move over to that.

	Arnd
