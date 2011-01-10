From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 10 Jan 2011 08:53:14 -0500 (EST)
Subject: [PATCH] ARM: sched_clock: improve mult/shift accuracy with high
	frequency clocks
In-Reply-To: <20110110105120.GA12552@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1012202014500.10437@xanadu.home>
	<20101221105149.GO28157@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1012291703300.10437@xanadu.home>
	<20110103003718.GF17727@n2100.arm.linux.org.uk>
	<1294084049.2571.30.camel@work-vm>
	<20110109105200.GC31708@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101092224320.3455@xanadu.home>
	<20110110105120.GA12552@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101100851300.6883@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jan 2011, Russell King - ARM Linux wrote:

> With a 32-bit or smaller cyclecounter, as 32-bit x 32-bit can never
> overflow a 64-bit destination, so if anything zero should be passed in
> this case.

That's the alternative suggestion I made as well.


Nicolas
