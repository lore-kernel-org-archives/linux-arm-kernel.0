From: dan@debian.org (Daniel Jacobowitz)
Date: Tue, 2 Feb 2010 19:50:38 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100202224322.GD29701@n2100.arm.linux.org.uk>
References: <20100111215816.GA1068@caradoc.them.org>
	<1263292498.29654.26.camel@pc1117.cambridge.arm.com>
	<20100112142523.GA28804@caradoc.them.org>
	<20100128202124.GA29606@caradoc.them.org>
	<20100202224322.GD29701@n2100.arm.linux.org.uk>
Message-ID: <20100203005038.GA16356@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 10:43:22PM +0000, Russell King - ARM Linux wrote:
> Umm, today there were patches posted using hardware support for
> breakpoints / watchpoints.  I've not read through those patches
> yet, but in light of hardware support, do we really need this patch
> anymore?

Yes, it's unrelated.  Hardware breakpoints are a constrained resource,
but we can insert unlimited software breakpoints (and often need to
exceed the hardware breakpoint limit).

-- 
Daniel Jacobowitz
CodeSourcery
