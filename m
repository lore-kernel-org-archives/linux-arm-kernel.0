From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 23:31:07 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <87vcr2w6pf.fsf@free.fr>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<20111101192343.GA32003@mudshark.cambridge.arm.com>
	<20111101194154.GU19187@n2100.arm.linux.org.uk>
	<20111101211933.GA32442@mudshark.cambridge.arm.com>
	<20111101230905.GV19187@n2100.arm.linux.org.uk>
	<87vcr2w6pf.fsf@free.fr>
Message-ID: <20111102233107.GG12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 10:33:00PM +0100, Robert Jarzmik wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > However, we don't know whether removing the code will then prevent it
> > rebooting even for a userspace-invoked reboot.  We need feedback from
> > the platform maintainer for that (added Philipp and Robert in the
> > hope one of them can answer this - and maybe send a patch to fix it.)
> 
> OK, I tested the serie on mioa701 board, and everything works as before. I
> tested it with mioa701.c amended so that no more halt/reboot hooks are used
> anymore. The resources freeing is gone as well.
> 
> I will submit the following patch [1] to get rid of the hooks to Eric, unless
> you want it in your tree.

I think I should pick it up because I have a patch changing the
.soft_reboot stuff.
