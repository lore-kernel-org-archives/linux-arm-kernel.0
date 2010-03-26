From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 26 Mar 2010 08:23:44 +0800
Subject: RFC: ARM Boot standard for passing device tree blob
In-Reply-To: <20100325234053.GB26649@yookeroo>
References: <fa686aa41003240811l6f40c8cfs6fdad496facdc089@mail.gmail.com>
	<20100325210409.GH24984@n2100.arm.linux.org.uk>
	<20100325234053.GB26649@yookeroo>
Message-ID: <201003260823.44829.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > ===Required System State===
> > > *Quiesce all DMA
> > > *CPU register contents
> > > **r0 = 0
> > > **r1 = Linux machine number (as defined in the ARM Linux machine
> > > database) or 0
> >
> > 0 is a valid machine number.  What is your purpose of passing 0?
> 
> Presumably a machine number will need to be allocated to mean "use the
> device tree instead of fixed machine number info".

I've been using 0xffffffff to indicate that this is a 'device-tree' platform. 
The value isn't really important, just that we agree on something.

Cheers,


Jeremy
