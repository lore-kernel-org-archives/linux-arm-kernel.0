From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 11:35:08 +0100
Subject: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and .phys_io
In-Reply-To: <1279793204.27276.129.camel@pororo.lan>
References: <1279073377.400469.233833413341.0.gpush@pororo>
	<1279073377.404006.432977736300.3.gpush@pororo>
	<AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
	<20100720100448.GB32702@n2100.arm.linux.org.uk>
	<1279621292.27276.19.camel@pororo.lan>
	<1279629158.27276.29.camel@pororo.lan>
	<20100721085024.GD6009@n2100.arm.linux.org.uk>
	<1279703355.27276.100.camel@pororo.lan>
	<20100722094643.GB31293@n2100.arm.linux.org.uk>
	<1279793204.27276.129.camel@pororo.lan>
Message-ID: <20100722103508.GF31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 12:06:44PM +0200, Jeremy Kerr wrote:
> > Meanwhile, I'm happy enough to merge this patch (or the optimized one)
> > and the follow-on patch which kills off the initializers.
> 
> OK, I will send a tree inclusion request for linux-next.

BTW, this may cause lots of conflicts from SFR when the follow-on patch
which deletes the initializers is merged.  So rather than keeping this
separate, it probably makes more sense for this patch to be merged into
my tree now.
