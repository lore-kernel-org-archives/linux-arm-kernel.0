From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Apr 2011 09:30:00 +0100
Subject: RFC, GIC based smp_cross_call cleanup suggestion
In-Reply-To: <89732ceb-5e61-4601-83dc-f6a315a7c9aa@VA3EHSMHS023.ehs.local>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
	<20110402085133.GE8482@n2100.arm.linux.org.uk>
	<BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
	<BANLkTimjyBzh3Kc+1njcBBYCouKdSWhgng@mail.gmail.com>
	<20110403103730.GB4213@n2100.arm.linux.org.uk>
	<89732ceb-5e61-4601-83dc-f6a315a7c9aa@VA3EHSMHS023.ehs.local>
Message-ID: <20110404083000.GB19042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2011 at 03:15:27PM -0600, John Linn wrote:
> I realize my SMP patch set I just sent out doesn't take this into
> account yet.  
> 
> I thought I needed to get it out for review since there's likely to
> be changes.
> 
> I can make this change to my patch set easily if it's the direction you go.

If we're going to be doing a lot of consolidation in the platform support
code during this merge window, it will mean that it'll be extremely
difficult to carry new platforms along side as they'll need to be
regularly updated.

Committing new platform support in the middle of the consolidation effort
also invites problems with the consolidation patches needing to be updated
before they can be applied.

As I mentioned in the OMAP git pull discussion, I think we should reserve
this cycle for consolidation effort and bug fixes only, otherwise things
will get really sticky.
