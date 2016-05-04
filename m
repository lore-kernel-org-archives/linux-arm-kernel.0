From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 May 2016 13:15:41 +0100
Subject: Loss of zeniv.linux.org.uk - my git tree now, potentially email, and
 more
Message-ID: <20160504121541.GQ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Things are going to be particularly difficult for the upcoming merge
window for me.

Right now, the machine which I host my git tree became partially
unresponsive in the early hours of Monday morning - the kernel was
up and running, but userspace was completely dead.  The machine would
ping, and accept tcp connections, but that was all.

While requesting on-site engineers to reset/power cycle the box, it
turns out that the (three year old) power supply has developed an
identical fault to the previous power supply, where the machine only
stays powered on for less than a second before power collapses and it
cycles.

In theory, this is a simple matter of either getting the power supply
replaced, or getting access to the hosting site.  However, it appears
that despite the machine owner and myself being able to get access
three years ago, Vodafone (the hosting company) are now telling is that
we are not permitted physical access to the machine.  That makes repair
or replacement rather difficult.

It sounds like Vodafone have lost part of their customer database.

The latest update this morning is that we've supplied Vodafone with the
necessary details, and we're waiting for their response before we
re-submit our physical access request.

The long and short of it is... my git tree in linux-next is currently
frozen in its -rc4 state, and is currently inaccessible until we get
this resolved, and we have no timescale for its resolution at present.
While I can point git.arm.linux.org.uk elsewhere at the moment, there's
another issue lurking (see below.)

Since we are currently at -rc6, and either -rc7 next week or the
merge window opening, this is going to be a problem.

Another thing to bring up is that I've mentioned to Alan Cox about his
linux.org.uk domain.  Obviously, my arm.linux.org.uk is dependent on
Alan's linux.org.uk domain.  The primary name server was this failed
machine, and the domain appears to have an unusually short expiry
of just one week.

I've discussed with Alan, and he has migrated it to his ISP, but his
ISP doesn't do sub-domains, this may present me with a problem.  To
preempt problems, while this email address is still working, I now
have in place armlinux.org.uk, and I will be transitioning everything
over to this new domain in the coming days/weeks.  Hence, expect me
to start sending email from @armlinux.org.uk addresses.

Obviously, this also means git pulls will (eventually) start coming
from git.armlinux.org.uk as well.

However, I hope to keep at least arm.linux.org.uk email active for a
while yet.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
