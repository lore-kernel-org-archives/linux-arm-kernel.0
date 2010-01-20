From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jan 2010 09:53:12 +0000
Subject: make PHYS_OFFSET determined at run time (unfinished)
In-Reply-To: <1263954112.3207.73.camel@linux-1lbu>
References: <20100119083803.GA17904@pengutronix.de>
	<4B561581.6060400@bluewatersys.com>
	<20100120005505.GD26562@trinity.fluff.org>
	<1263954112.3207.73.camel@linux-1lbu>
Message-ID: <20100120095312.GA20313@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 08:21:52PM -0600, Steve Chen wrote:
> On Wed, 2010-01-20 at 00:55 +0000, Ben Dooks wrote:
> > Or of course, boot zImages. I belive u-boot has support for zImage.
> 
> Is there a clean way to pass kernel parameters and machine type from
> u-boot to zImage?  Last time I boot zImage in u-boot, some ugly hack was
> needed in ARM startup code.  Just wondering if there is a better way.

I don't know about the u-boot side of things, but the kernel has
supported a clean way to do this for the last 10 or so years.
