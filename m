From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 14 Sep 2010 13:37:42 -0400 (EDT)
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <1284468849.933.2.camel@e102109-lin.cambridge.arm.com>
References: <4C8DD588.7040009@endruntechnologies.com>
	<201009131043.48688.marek.vasut@gmail.com>
	<AANLkTimti4ajAOR0_aZ8aeGu9PN4a0MX8dbpg6dpZJYf@mail.gmail.com>
	<20100913101039.GC2614@kw.sim.vm.gnt>
	<000001cb5409$4726e000$4b4d010a@Emea.Arm.com>
	<1284468849.933.2.camel@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1009141333090.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Sep 2010, Catalin Marinas wrote:

> I think the Thumb-2 branch goes up to 16MB range. The Thumb-1 may be
> smaller but we don't support this in the kernel. That's why Thumb-2
> modules are within 8MB below PAGE_OFFSET. But this leaves us with
> maximum 8MB of kernel size.

Hmmm.  Would be worth moving the pkmap area below modules then.


Nicolas
