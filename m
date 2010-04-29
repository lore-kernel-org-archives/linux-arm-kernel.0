From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Apr 2010 17:39:39 +0100
Subject: Decompression failure in an inexplicable case
In-Reply-To: <1272558886.15152.4.camel@e102109-lin.cambridge.arm.com>
References: <A809F2C8-74CA-474E-92B0-08A5227B7C3F@prograde.net>
	<1272558886.15152.4.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100429163939.GF4877@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 05:34:46PM +0100, Catalin Marinas wrote:
> On Thu, 2010-04-29 at 16:27 +0100, Michael Cashwell wrote:
> > If I omit CPUFreq support [CONFIG_CPU_FREQ is not set], or enable both
> > it and its debugging support [CONFIG_CPU_FREQ_DEBUG=y], the kernel
> > builds and runs seemingly fine.
> > 
> > But if I have CONFIG_CPU_FREQ enabled but NOT its debugging support
> > then kernel builds OK (including full mrproper cleanings in between):
> 
> BTW, one of the suggestions at the time was to try this:

Another thing is to ask which kernel version.  There's a number of fixes
which recently went in to both -stable and -rc to fix problems with
the decompressor.
