From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 8 Aug 2013 19:23:00 +0100
Subject: __ARM_ARCH_2__
In-Reply-To: <1375985035.647275432@f399.i.mail.ru>
References: <CANEcUBWAYe1Zkes3ZxFr9Copwh-H9Meijg6eupiQaKRUR0Jmdg@mail.gmail.com>
 <20130808082719.GH23006@n2100.arm.linux.org.uk>
 <20130808175253.GB2356@localhost.localdomain>
 <1375985035.647275432@f399.i.mail.ru>
Message-ID: <20130808182300.GD2356@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 10:03:55PM +0400, Alexander Shiyan wrote:
> > On Thu, Aug 08, 2013 at 09:27:19AM +0100, Russell King - ARM Linux wrote:
> > > On Thu, Aug 08, 2013 at 10:08:02AM +0800, zhaobin xv wrote:
> > > > I don't know what the"__ARM_ARCH_2__" mean?
> > > > "__ARM_ARCH_2__" is definded by gcc or definded byarmlinux?
> > > > where does it come from? what does it want to do?
> > > 
> > > You could try a few things before posting:
> > > 
> > > 1. You could try grepping the kernel source to find out if anything
> > >    in the kernel defines it.
> > > 2. You could try asking google and seeing what it returns.
> > > 
> > > Either of those will tell you that it's not defined by the kernel but by
> > > the compiler.  For me, the first link on google explains it really well.
> > 
> > Should that code go away?  I believe we don't support v2 or v3 any more...
> > Did teqp actually work in 32-bit modes?
> 
> "ARM: 7770/1: remove residual ARMv2 support from decompressor":
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm/boot/compressed/head.S?id=52c08a9e399739979027ea1e463f5529476da104

Job done, then

Cheers
---Dave 
