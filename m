From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 31 Jan 2013 15:31:57 -0500 (EST)
Subject: [PATCH v2 4/4] irqchip: gic: Perform the gic_secondary_init()
 call via CPU notifier
In-Reply-To: <20130131175526.GE23505@n2100.arm.linux.org.uk>
References: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
 <1359476319-23720-5-git-send-email-catalin.marinas@arm.com>
 <alpine.LFD.2.02.1301291734140.6300@xanadu.home>
 <20130129231205.GA25176@MacBook-Pro.local>
 <alpine.LFD.2.02.1301291907340.6300@xanadu.home>
 <20130131112538.GW23505@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301311230140.6300@xanadu.home>
 <20130131175526.GE23505@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1301311521310.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Jan 2013, Russell King - ARM Linux wrote:

> On Thu, Jan 31, 2013 at 12:32:11PM -0500, Nicolas Pitre wrote:
> > On Thu, 31 Jan 2013, Russell King - ARM Linux wrote:
> > 
> > > I haven't tried Versatile Express yet as it has the TC2 tile on, and I
> > > don't yet a boot loader on it which is capable of TFTP (which makes it
> > > rather useless to me - I've been saying this for a time now but this is
> > > probably the first time publically.)  I'm thinking about putting the
> > > CA9x4 tile back on because that's a lot more functionally useful to me
> > > than TC2.
> > 
> > You might be interested by this then:
> > 
> > http://lists.linaro.org/pipermail/linaro-dev/2012-October/014136.html
> 
> Great news.  Everyone has been telling me that there's no uboot for TC2,
> or "we think Linaro might have something but we don't really know".

Note that I cobbled those instructions on my own and the result is not 
officially supported by Linaro.  This is obviously not suitable for 
setting up products or demo systems, but for a kernel developer I think 
such a setup is invaluable.


Nicolas
