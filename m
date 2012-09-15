From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 14 Sep 2012 20:02:09 -0400
Subject: [PATCH] ARM: Dove: allow PCI to be disabled
In-Reply-To: <alpine.LFD.2.02.1209101239510.28681@xanadu.home>
References: <E1TAnGn-00086i-Lb@rmk-PC.arm.linux.org.uk>
 <20120909204705.GD3451@lunn.ch>
 <20120909205521.GI13739@n2100.arm.linux.org.uk>
 <20120909210126.GM4575@titan.lakedaemon.net>
 <20120910004511.GN13739@n2100.arm.linux.org.uk>
 <20120910014422.GQ4575@titan.lakedaemon.net>
 <alpine.LFD.2.02.1209101239510.28681@xanadu.home>
Message-ID: <20120915000209.GC5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 12:45:10PM -0400, Nicolas Pitre wrote:
> So the simplest thing to do is to keep the select there to prevent build 
> issues and remember that perfection is the enemy of the good.

Yes, I have to remind myself of that a lot.  To the point I've
considered getting a tattoo of it somewhere.  :-)

You are right.  I was primarily trying to drill down on something I
didn't understand, which is how leaving out that line could cause a
regression.  The patch is fine, of course, I'll pull it in in my next
round.  Anything else in this thread will be purely me attempting to
make sure I fully understand git and the merge process wrt to causing
regressions.

thx,

Jason.
