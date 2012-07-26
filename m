From: liuj97@gmail.com (Jiang Liu)
Date: Thu, 26 Jul 2012 09:40:53 +0800
Subject: PCI mini-summit
In-Reply-To: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
References: <CAErSpo5Ea_Rd2QSUXT13riDgHrkMGiN43+QiFTZYepHi-rg0Vw@mail.gmail.com>
Message-ID: <5010A025.5000002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,
	Really want to attend the mini-summit, have strong interests in host 
bridge hotplug and PCI hotplug core rework. But it may be a little later
for me to apply for VISA:(
	I'll try to send out a draft version for PCI hotplug rework for
comments soon.

	Thanks!
	Gerry

On 07/25/2012 11:33 AM, Bjorn Helgaas wrote:
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
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
