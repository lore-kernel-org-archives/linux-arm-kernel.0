From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 23:06:06 +0000
Subject: submitting new ARM platforms
In-Reply-To: <083DF309106F364B939360100EC290F804F54660B1@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F54660B1@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20091119230606.GJ22232@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 06:23:36PM +0100, Kevin Wells wrote:
> We are the process of getting Linux optimized to the NXP LPC32X0 SoC and would
> like to get the files submitted for inclusion into the mainline. Currently, this
> consists of 4 CPU variants (all very similar) and 3 different boards (all very
> different!).

Hmm...

> The kernel and most of the drivers have been ported to this board for about a
> year now, with occasional tweaks needed as the kernel version progresses. A
> number of developers are using the kernel on these boards now. We are getting
> a lot of requests to get this into mainline!
> 
> I don't want to deluge everyone or anyone all at once, but would like to get
> this started!

Well, bear in mind that there are many mailing lists, each addressing
a particular part of the kernel.  You need to send your patches to the
relevant mailing list(s).

For instance, when submitting a USB driver, you need to include the USB
mailing list.  If it doesn't touch any arch/arm code, then you probably
don't need to send it to the linux-arm-kernel list.

Probably the right thing to do is to start with the core support code -
the stuff for arch/arm which is needed to get the basic system up and
running.  Once that's been reviewed and sorted out, consider sending
out the drivers.

> Most of the work for this is already done up to 2.6.32-rc6. Whats the best
> approach to get started here? I would like to start small with just the basic
> arch files with 1 or 2 boards and later add in the other support as more of the
> optimzied chip specific drivers are merged in. As of now, the only change
> required ouside of the existing kernel source tree is the arch/arm/Kconfig and
> arch/arm/Makefile files and the addition of the arch/arm/mach-lpc32xx/ subdir.

It sounds like you've already worked this out.

> Should I start posting patches for the basic mach- area first?

Sure.
