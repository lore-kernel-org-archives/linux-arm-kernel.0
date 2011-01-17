From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 12:34:09 +0000
Subject: [PATCH] ARM: smp: Fix Unknown IPI message 0x1
In-Reply-To: <d93218062aa1e6948453d1ddd5b9e2b0@mail.gmail.com>
References: <1295265395-28485-1-git-send-email-santosh.shilimkar@ti.com>
	<20110117120104.GB20615@n2100.arm.linux.org.uk>
	<72ca984700f139fea98558783dde38f3@mail.gmail.com>
	<20110117121951.GC20615@n2100.arm.linux.org.uk>
	<1295267193.21557.14.camel@e102109-lin.cambridge.arm.com>
	<d93218062aa1e6948453d1ddd5b9e2b0@mail.gmail.com>
Message-ID: <20110117123409.GD20615@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 06:01:31PM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> > Sent: Monday, January 17, 2011 5:57 PM
> > To: Russell King - ARM Linux
> > Cc: Santosh Shilimkar; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH] ARM: smp: Fix Unknown IPI message 0x1
> >
> > At least on the ARM Ltd platforms, the boot monitor waits for any
> > interrupt (it is in WFI). I can't tell about other platforms.
> >
> Same for OMAP4. Any SGI will do.

Ok, so we can convert OMAP, Realview, Versatile Express to use SGI0...
that's a start!
