From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Oct 2009 15:52:12 -0400 (EDT)
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <20091027194218.GD22412@n2100.arm.linux.org.uk>
References: <1256123277.3851.36.camel@debian-nb>
	<200910271937.57146.jpihet@mvista.com>
	<alpine.LFD.2.00.0910271454110.10545@xanadu.home>
	<200910272012.53488.jpihet@mvista.com>
	<alpine.LFD.2.00.0910271533060.10545@xanadu.home>
	<20091027194218.GD22412@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0910271551340.10545@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct 2009, Russell King - ARM Linux wrote:

> On Tue, Oct 27, 2009 at 03:35:31PM -0400, Nicolas Pitre wrote:
> > And is there a reason for touching sp in the error case?
> 
> Returning 'sp' seems to be a sane thing to do - otherwise debuggers
> analysing core dumps could be confused about the location of data on
> the stack.

Good point.


Nicolas
