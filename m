From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 11 Dec 2012 16:34:27 +0000
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <20121211160956.GF16759@mudshark.cambridge.arm.com>
References: <20121204124047.GM23368@mudshark.cambridge.arm.com>
 <20121204133326.GE14363@n2100.arm.linux.org.uk>
 <20121204134010.GP23368@mudshark.cambridge.arm.com>
 <20121204143724.GF14363@n2100.arm.linux.org.uk>
 <20121204161113.GT23368@mudshark.cambridge.arm.com>
 <50BE28C6.2010403@gmail.com>
 <20121204171628.GF5314@mudshark.cambridge.arm.com> <50BE31E9.3040404@arm.com>
 <20121204173045.GI5314@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1212111558270.17523@kaball.uk.xensource.com>
 <20121211160956.GF16759@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1212111621220.17523@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Dec 2012, Will Deacon wrote:
> On Tue, Dec 11, 2012 at 04:04:20PM +0000, Stefano Stabellini wrote:
> > Hi!
> 
> Hi Stefano,
> 
> > Sorry for taking so long to reply but I admit I missed the thread
> > entirely until now. I would appreciate if you could CC
> > xen-devel at lists.xen.org and/or me for virtualization related
> > discussions.
> 
> I did CC xen-arm at lists.xen.org,
  
Thanks!
I don't know why I didn't receive it then :-\

In any case xen-devel is the right place for upstream related
discussion.


> but you've dropped that list in your
> reply...

Yeah.. that's because I didn't receive the original email and I had to
download the mailing list archives, sorry about that.


> > On the Xen side there are not going to be any problems related to SMP
> > and holding pens, because secondary CPUs only come into existence after
> > the first CPU calls the HYPERVISOR_vcpu_op hypercall (still missing on
> > ARM).
> 
> Ok. Would you be willing/able to wrap this in a PSCI interface when you do
> add SMP support for ARM?

I grepped for PSCI in the Linux tree but I couldn't find anything.
Also I googled for ARM PSCI and nothing of value came up. Can I find a
doc that explains what PSCI is anywhere?
