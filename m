From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Jul 2012 15:36:25 +0100
Subject: [Xen-devel] [PATCH 02/24] xen/arm: hypercalls
In-Reply-To: <20120727142101.GA6802@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120726163352.GC9222@phenom.dumpdata.com>
 <1343380659.6812.106.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1207271350370.26163@kaball.uk.xensource.com>
 <20120727142101.GA6802@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1207271526420.26163@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jul 2012, Russell King - ARM Linux wrote:
> On Fri, Jul 27, 2012 at 02:02:18PM +0100, Stefano Stabellini wrote:
> > > > > +/******************************************************************************
> > > > > + * hypercall.h
> > > > > + *
> > > > > + * Linux-specific hypervisor handling.
> > > > > + *
> > > > > + * Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Citrix, 2012
> > > > > + *
> > > > > + * This program is free software; you can redistribute it and/or
> > > > > + * modify it under the terms of the GNU General Public License version 2
> > > > > + * as published by the Free Software Foundation; or, when distributed
> > > > > + * separately from the Linux kernel or incorporated into other
> > > > > + * software packages, subject to the following license:
> > > > > + *
> > > > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > > > + * of this source file (the "Software"), to deal in the Software without
> 
> Erm, is that an additional restriction on the GPL which prevents me from
> shipping this code on a CD and charging for the act of creating the CD
> and shipping it?  That would technically make the above statement
> incompatible with the GPL.

IMNAL but this is just an alternative, less strict, MIT license for this
file, same as the x86 counterpart
(arch/x86/include/asm/xen/hypercall.h). The intent is to allow other
operating systems, the BSDs for example, to be able to use it if they
want to.
Actually, given that the ARM implementation is not inline, I should
remember to add this copyright header to the assembly source file too.
