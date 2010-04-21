From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 21 Apr 2010 18:41:40 +1000
Subject: [RFC/PATCH] dns323: Support for HW rev C1
In-Reply-To: <20100421083702.GA11425@n2100.arm.linux.org.uk>
References: <1271838486.2330.139.camel@pasglop>
	<1271838700.2330.143.camel@pasglop>
	<20100421083702.GA11425@n2100.arm.linux.org.uk>
Message-ID: <1271839300.2330.145.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-04-21 at 09:37 +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 21, 2010 at 06:31:40PM +1000, Benjamin Herrenschmidt wrote:
> > Do you have a hook in ARM for adding something to /proc/cpuinfo where I
> > could export the board revision ? Or a "standard" practice to do that ?
> 
> That's the purpose of system_rev, originally provided for Netwinders to
> identify revision 3, 4, or 5 of the Netwinder hardware.

Ah, nice ! I missed that. I can also replace my dns323_rev with that in
fact (though it's nice to have an enum so gcc doesn't warn me all the
times about lack of a "default" statement in switch... oh well).

I'll do something about it when I next respin the patch.

Cheers,
Ben.
 
