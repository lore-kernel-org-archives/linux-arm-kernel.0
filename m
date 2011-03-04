From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 4 Mar 2011 22:50:23 +0530
Subject: [PATCH 00/17] omap4: pm: suspend, hotplug and cpuilde support
In-Reply-To: <87oc5txf0d.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<87oc5txf0d.fsf@ti.com>
Message-ID: <aac02e1097a15c84cf795db5bfc49b48@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Thursday, March 03, 2011 5:16 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 00/17] omap4: pm: suspend, hotplug and cpuilde
> support
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > This series adds OMAP4 suspend and cpuidle support till MPU
> subsystem
> > (MPUSS) off-mode. The suspend on SMP machines uses cpu-hotplug
> > infrastructure to take down the non-boot CPUs. We put secondary
> > CPU(CPU1 in OMAP4) to OFF state via cpu-hotplug.
> > In cpuidle too, low power states are attempted only when the
> > CPU1 is put to OFF state via cpu-hotplug because of hardware
> > constraints.
>
> Minor nit on patch subjects:  both OMAP and PM are acronyms, please
> capitalize.
>
> Also, can you rebase this on Paul's integration-2.6.39 branch?
> There
> are several things in this series that conflict with changes there.
>

Rebased branch against your pm-core.

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap4_pm_for-next

Regards,
Santosh
