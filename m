From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 02 Nov 2011 22:33:00 +0100
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <20111101230905.GV19187@n2100.arm.linux.org.uk> (Russell King's
	message of "Tue, 1 Nov 2011 23:09:05 +0000")
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<20111101192343.GA32003@mudshark.cambridge.arm.com>
	<20111101194154.GU19187@n2100.arm.linux.org.uk>
	<20111101211933.GA32442@mudshark.cambridge.arm.com>
	<20111101230905.GV19187@n2100.arm.linux.org.uk>
Message-ID: <87vcr2w6pf.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> However, we don't know whether removing the code will then prevent it
> rebooting even for a userspace-invoked reboot.  We need feedback from
> the platform maintainer for that (added Philipp and Robert in the
> hope one of them can answer this - and maybe send a patch to fix it.)

OK, I tested the serie on mioa701 board, and everything works as before. I
tested it with mioa701.c amended so that no more halt/reboot hooks are used
anymore. The resources freeing is gone as well.

I will submit the following patch [1] to get rid of the hooks to Eric, unless
you want it in your tree.

Cheers.

-- 
Robert

[1]
