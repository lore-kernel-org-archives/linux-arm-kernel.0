From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 27 Jul 2012 07:45:21 +1000
Subject: PCI mini-summit
In-Reply-To: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
References: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
Message-ID: <1343339121.2118.5.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-07-24 at 21:33 -0600, Bjorn Helgaas wrote:
> We're planning a PCI mini-summit on Tuesday, August 28, in San Diego.
> If you'd like an invitation, let me know.
> 
> We haven't drafted an agenda yet, but based on ideas we've heard so
> far, we'll likely talk about some of the following topics:
> 
>       Host bridge hotplug
>       PCI hotplug core rework
>       VFIO v2 for KVM
>       Dynamic resource assignment
>       SRIOV
>           Management: driver (module parms) vs core (sysfs?)
>           Dynamic/static: changing number of VFs requires driver cooperation
>       Candidates for unification/moving from arch code to the core:
>           res->parent usage
>           Claiming resources
>           Unassigned BAR detection
>           ECAM (a.k.a. MMCONFIG)
>           Domain (a.k.a. PCI segment) support
>           MPS config
>           MPS safety with respect to hotplug
> 
> I've also heard that PCI-on-ARM may be of interest, so if you want to
> talk about that and possibly add some topics, let me know.

We don't necessarily need a firm agenda, we can put the list of topics
and pick them in time with a hourly stop to decide whether to move on to
a different one.

Unless some people want to actually present something in which case we
can allocate them a slot (those people need to let us know asap).

Cheers,
Ben.
