From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Nov 2013 11:35:57 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
Message-ID: <20131119113557.GI5914@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > > That
> > > sounds like an arcane board file equivalent, and is counter to the
> > > entire reason for using UEFI and ACPI -- having a well-defined
> > > (excluding particular driver bindings, and I'm not arguing well-defined
> > > means nice) stable standard that allows the kernel to boot on an
> > > arbitrary platform without requiring arbitrary platform-specific code
> > > everywhere in the boot path.
> > >
> > > It might not be pretty, and it will certainly require a lot of work, but
> > > I'd prefer it at least for a semblance of uniformity.
> >
> > That is a red herring -- that booting standard has _nothing_ to do with
> > ACPI. Once you've got a standard that is well-defined enough like that,
> > you no longer need the runtime portions of ACPI to deal with it. You
> > can just hardcode it. You need a way to probe _which_ type of standard
> > is used, but from there on out you can assume that things are the same
> > way.
> 
> The UEFI spec pulls in portions of ACPI. I do not know the full extent
> of the interaction between the two, but I know that they are not
> completely decoupled. As you have pointed out we are not experienced
> with ACPI or UEFI, so I don't think we can make statements that one is
> perfectly fine without the other.

Given Leif's comments it seems that they are decoupled sufficiently to
be considered separately.

Apologies for adding to the confusion here.

Mark.
