From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 29 Nov 2013 09:43:08 -0800
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131129131359.GH4634@e103592.cambridge.arm.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129023554.GA14239@kroah.com>
 <20131129093713.GC22771@ulmo.nvidia.com>
 <20131129095703.GV16735@n2100.arm.linux.org.uk>
 <20131129131359.GH4634@e103592.cambridge.arm.com>
Message-ID: <20131129174308.GC5635@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 01:13:59PM +0000, Dave Martin wrote:
> On Fri, Nov 29, 2013 at 09:57:03AM +0000, Russell King - ARM Linux wrote:
> > On Fri, Nov 29, 2013 at 10:37:14AM +0100, Thierry Reding wrote:
> > > There's a large gap between how fast new SoCs are supposed to tape out
> > > and the rate at which new code can be merged upstream. Perhaps some of
> > > that could be mitigated by putting more of the complexity into firmware
> > > and that's already happening to some degree for ARMv8. But I suspect
> > > there's a limit to what you can hide away in firmware while at the same
> > > time giving the kernel enough information to do the right thing.
> > 
> > One of the bigger issues which stands in the way of companies caring
> > about mainstream support is closed source IPs like VPUs and GPUs.
> > 
> > If you have one of those on your chip, even if the kernel side code
> > is already under the GPL, normally that code is not "mainline worthy".
> > Also, as the userspace code may not be open source, some people object
> > to having the open source part in the kernel.
> > 
> > So for customers to be able to get the performance out of the chip,
> > they have to stick with having non-mainline kernel.
> > 
> > At that point, why bother spending too much time getting mainline
> > support for the device.  It's never going to be fully functional in
> > mainline.  It doesn't make sense for these SoC companies.
> 
> Putting effort into upstream support for something that is only relevant
> to GPUs (or VPUs) does look less valuable for us right now, unless it
> encourages people to start posting more GPU/VPU code upstream, and we
> know there are other blockers there.

What are these "other blockers"?
