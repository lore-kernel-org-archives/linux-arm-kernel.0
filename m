From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 08 Oct 2010 17:27:05 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <20101008203528.GN7558@atomide.com>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<20101007212707.GI7558@atomide.com>
	<1286488713.23836.112.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010072125440.3107@xanadu.home>
	<20101008203528.GN7558@atomide.com>
Message-ID: <alpine.LFD.2.00.1010081725370.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Oct 2010, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [101007 18:19]:
> > On Thu, 7 Oct 2010, Daniel Walker wrote:
> > 
> > > On Thu, 2010-10-07 at 14:27 -0700, Tony Lindgren wrote:
> > > 
> > > > Can you please pass the read and write functions to the driver
> > > > in platform_data? We are already booting kernels with both
> > > > ARMv6 and 7 compiled in.
> > > 
> > > What kind of situation did you want to use it in ? I was thinking about
> > > how arm could have these functions in a header file, that way we
> > > wouldn't duplicate in multiple places.
> > > 
> > > > Also, as it's a driver, other architectures may want to use it too.
> > > 
> > > I'm not sure if this model fits other architectures tho. They may not
> > > have the same read/write/status sorts of stuff. Atleast I don't know
> > > enough about other architectures jtags .
> > 
> > This is ARM specific, and even not all ARM implementations have it.
> 
> Are you sure?

Certainly.

> I thought DCC is JTAG specific standard?

Not at all.  JTAG standard is a bit like Ethernet while DCC would be 
HTTP.


Nicolas
