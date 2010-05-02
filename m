From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 May 2010 23:34:24 +0100
Subject: [at91] Save power by disabling the processor clock when CPU is
	idle
In-Reply-To: <j2ncd73a99e1005021310w1c6471et6c58ffce68a4137b@mail.gmail.com>
References: <1271156732l.25331l.7l@i-dmzi_al.realan.de>
	<j2ncd73a99e1005021310w1c6471et6c58ffce68a4137b@mail.gmail.com>
Message-ID: <20100502223424.GA11466@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 02, 2010 at 10:10:29PM +0200, avictor.za at gmail.com wrote:
> > Disable the processor clock when the CPU is idle.
> >
> > This saves much more power than merely entering 'Wait for Interrupt' mode.
> > Since JTAG-debugging doesn't work when the processor clock is switched off,
> > make it conditional on CONFIG_DEBUG_KERNEL.
> >
> > Signed-off-by: Anders Larsen <al@alarsen.net>
> > Cc: Andrew Victor <avictor.za@gmail.com>
> 
> Acked-by: Andrew Victor <linux@maxim.org.za>
> 
> Russell:  It is patch 6053/1 in the patch-system.

Ok, thanks.  Where do we stand wrt the other two patches (5966/1 and
5967/1) ?
