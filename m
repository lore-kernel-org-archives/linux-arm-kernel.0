From: John.Linn@xilinx.com (John Linn)
Date: Wed, 30 Mar 2011 07:37:10 -0600
Subject: [PATCH V5 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <201103301529.03648.arnd@arndb.de>
References: <1301444651-18008-1-git-send-email-john.linn@xilinx.com>
	<201103301344.45307.arnd@arndb.de>
	<f4872ed7-b6e4-4050-9445-5176f5aa961a@VA3EHSMHS017.ehs.local>
	<201103301529.03648.arnd@arndb.de>
Message-ID: <807f31a6-c9ff-4f35-bece-e0222a8e1fda@VA3EHSMHS006.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Wednesday, March 30, 2011 7:29 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org;
> linux at arm.linux.org.uk; catalin.marinas at arm.com; glikely at secretlab.ca;
> jamie at jamieiles.com
> Subject: Re: [PATCH V5 3/4] ARM: Xilinx: base header files and
assembly
> macros
> 
> On Wednesday 30 March 2011, John Linn wrote:
> > Yes that makes sense.  We don't have immediate plans for PCI and
> > I was assuming when we add PCI we would need to change that.
> >
> > If you think I shouldn't put it off then I'll fix it now.  My
> > preference was to get the platform supported, then add more
features.
> 
> Getting it fixed properly depends a bit on the PCI implementation.
> I've been planning to clean up this part of the ARM architecture
> for some time and I can probably do it for one more platform when
> I get to it.

Sounds like it's fine to postpone it til we do PCI as I don't know all
the
details of the system yet. Soft logic in FPGAs is great :)

> 
> My idea for the multiplatform kernel is to have a global I/O space
> window (maybe 1 MB) that is in the same location in the virtual
> address space all the time, so any platform that wants to support
> PCI with direct-mapped I/O space can simply map it in there
> at boot time.
> 

Sounds like that will make it easier for everyone and more consistent.

Thanks,
John

> 	Arnd


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
