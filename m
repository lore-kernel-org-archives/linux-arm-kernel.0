From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 8 Jan 2016 15:01:42 +0000
Subject: [PATCH v2] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <CAPw-ZTmsLqgh6W6R0uLgQjueV7XjaGOD49CYCRYufJ43zT8Kyg@mail.gmail.com>
References: <CAPw-ZTmsLqgh6W6R0uLgQjueV7XjaGOD49CYCRYufJ43zT8Kyg@mail.gmail.com>
Message-ID: <20160108150142.GB10630@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Loc,

[CC'ed Jeremy - I know he is testing this on m400]

On Fri, Dec 18, 2015 at 06:12:20PM -0800, Loc Ho wrote:

[...]

> >> I put it together to make sure that it is there if any platform
> >> compliant with it relies on it and more importantly to prevent
> >> non-compliant implentations from trickling into the kernel,
> >> basically to prevent broken firmware implementations from being
> >> considered compliant and "working".
> >
> > That's a good point. However, AFAIK, AMD are using PSCI already in their
> > firmware implementation and that's what we recommend anyway if EL3 is
> > available.
> >
> > So this patch is mainly aimed at X-Gene since other implementations I'm
> > aware of have EL3 already. What are the chances of Applied Micro fixing
> > their firmware and actually using this patch? (not a question for you;
> > I'm hoping some Applied engineers would comment).
> >
> 
> Sorry that I missed this. This FW is now fixed and tested with Lorenzo
> patch. Though some minor manual patch will be required with recent
> kernel. I was going to get some one to ack the patch but got tied up
> with other matter. As for availability of the FW, it is currently
> internally only and will be available sometime next year for the next
> FW release. If any one interested in the FW, you can contact me.

I guess that by "some minor manual patch" you meant you had to rebase
the patch on top of mainline, I can post an updated version for you to
test.

Mind giving a tested-by if FW has been updated to comply with the specs
and tested with my patch applied ?

Thanks,
Lorenzo
