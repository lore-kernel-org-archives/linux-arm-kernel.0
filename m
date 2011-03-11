From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Mar 2011 23:43:32 +0530
Subject: [PATCH v2 00/19] OMAP4: PM: Suspend,
	CPU-hotplug and CPUilde support.
In-Reply-To: <874o79a60n.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com><87d3lycu0h.fsf@ti.com><3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com><871v2dd58y.fsf@ti.com><f1ee9adb49c6dbc49205c5ba70007e9a@mail.gmail.com><87k4g5a6n5.fsf@ti.com><420e5c6f0aff0bbd23b7f3e9c190ca97@mail.gmail.com>
	<874o79a60n.fsf@ti.com>
Message-ID: <99e2889f2135ff52fd9908c4855b301b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Friday, March 11, 2011 11:34 PM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Rajendra Nayak
> Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend,CPU-hotplug and
> CPUilde support.
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>

[...]

> > Thanks for clarification. The change is quite trivial. Will
> > update the branch with this change.
> > After testing it, will intimate you
>
> One other thing to check...
>
> I've now included Russell's devel branch into my pm-core branch.
> Can you rebase your series there?  I did a test rebase of v3 and it
> rebased fine (after dropping the patches that are already in devel.)
>
Great.

> After doing that, I get a compile error:
>
> arch/arm/mach-omap2/built-in.o: In function `mmu_on_label':
> /work/kernel/omap/pm/arch/arm/mach-omap2/sleep44xx.S:394: undefined
> reference to `PHYS_OFFSET'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2
>
> It looks like there might be some other changes in Russell's queue
> that you need to take into consideration.
>
Ok. Will check that.

Regards,
Santosh
