From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 28 Mar 2011 16:32:39 +0530
Subject: [PATCH v2 00/19] OMAP4: PM: Suspend,
	CPU-hotplug and CPUilde support.
In-Reply-To: <87mxkjusth.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com><87d3lycu0h.fsf@ti.com><49a5273c412bf9193a9f930e990d22d4@mail.gmail.com><87pqpxbqho.fsf@ti.com>
	<87mxkk1rni.fsf@ti.com><86f296cd6f86c03bc066efaf7cf2b537@mail.gmail.com>
	<87mxkjusth.fsf@ti.com>
Message-ID: <d6e3117993699fda33d37081605a9403@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Friday, March 25, 2011 8:54 PM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; Rajendra Nayak; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and
> CPUilde support.
>
> Hi  Santosh,
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>

[...]

>
> Before I rebase, I'll wait at least until -rc1 and/or Tony rebases
> to mainline.
>
> In the mean time, can you create two branches?  One with the
> dependencies and another with the OMAP4 PM series.  After some final
> review and testing, I'll merge the latter series and by then we'll
> probably have an -rc1 baseline.
>

Have created two branches as you suggested against latest
pm-core.

1) OMAP4-PM series:
git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap4_pm_pmcore_v3

2) Dependent patches
git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap4_pm_pmcore_dep

Also created an integration branch which merges 1) and 2)

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap4_pm_pmcore_int

Regards,
Santosh
