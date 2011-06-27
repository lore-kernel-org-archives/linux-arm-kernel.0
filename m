From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 27 Jun 2011 13:31:09 -0400 (EDT)
Subject: IRQS off tracer - is it useful or not?
In-Reply-To: <20110627165423.GA6222@n2100.arm.linux.org.uk>
References: <20110625132112.GH23234@n2100.arm.linux.org.uk>
	<4E08AF23.2060901@codeaurora.org>
	<20110627165423.GA6222@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1106271328190.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jun 2011, Russell King - ARM Linux wrote:

> So what I'm trying to get to the bottom of: should I care about the
> IRQS off hooks in the entry assembly code given that the existing IRQs
> off tracing seems to be useless for performing that task.  My own
> personal experience is saying a very big no to that.

Maybe using git to find out who submitted them and ask them if they 
still care?  This stuff must have worked for them at some point.


Nicolas
