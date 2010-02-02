From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Feb 2010 22:43:22 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100128202124.GA29606@caradoc.them.org>
References: <20100111215816.GA1068@caradoc.them.org>
	<1263292498.29654.26.camel@pc1117.cambridge.arm.com>
	<20100112142523.GA28804@caradoc.them.org>
	<20100128202124.GA29606@caradoc.them.org>
Message-ID: <20100202224322.GD29701@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 03:21:24PM -0500, Daniel Jacobowitz wrote:
> On Tue, Jan 12, 2010 at 09:25:23AM -0500, Daniel Jacobowitz wrote:
> > I'll plan on 0xf7f0 0xa000.
> 
> Like so.  Shall I send this to the patch system?
> 
> From: Daniel Jacobowitz <dan@codesourcery.com>
> 
> Recognize 0xf7f0 0xa000 as a 32-bit breakpoint instruction for
> Thumb-2.

Umm, today there were patches posted using hardware support for
breakpoints / watchpoints.  I've not read through those patches
yet, but in light of hardware support, do we really need this patch
anymore?
