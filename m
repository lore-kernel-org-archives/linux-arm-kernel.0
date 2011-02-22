From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 22 Feb 2011 21:28:21 +0100
Subject: [PATCHv3] amba: support pm ops
In-Reply-To: <20110222201529.GB29559@n2100.arm.linux.org.uk>
References: <201102212126.10742.rjw@sisk.pl> <201102222102.15089.rjw@sisk.pl>
	<20110222201529.GB29559@n2100.arm.linux.org.uk>
Message-ID: <201102222128.21601.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 22, 2011, Russell King - ARM Linux wrote:
> On Tue, Feb 22, 2011 at 09:02:14PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, February 22, 2011, Rabin Vincent wrote:
> > > Support pm_ops in the AMBA bus, required to allow drivers to use runtime pm.
> > > The implementation of AMBA bus pm ops is based on the platform bus
> > > implementation.
> > > 
> > > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> > 
> > Looks good.
> > 
> > Who's supposed to take it?
> 
> Does this help?
> 
> ARM PRIMECELL BUS SUPPORT
> M:      Russell King <linux@arm.linux.org.uk>
> S:      Maintained
> F:      drivers/amba/
> F:      include/linux/amba/bus.h

Still, it's power management, right?

Anyway, I guess that means you're going to take care of it. :-)

Thanks,
Rafael
