From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 25 Mar 2011 21:00:25 +0530
Subject: [PATCH v2 00/19] OMAP4: PM: Suspend,
	CPU-hotplug and CPUilde support.
In-Reply-To: <87mxkjusth.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com><87d3lycu0h.fsf@ti.com><49a5273c412bf9193a9f930e990d22d4@mail.gmail.com><87pqpxbqho.fsf@ti.com>
	<87mxkk1rni.fsf@ti.com><86f296cd6f86c03bc066efaf7cf2b537@mail.gmail.com>
	<87mxkjusth.fsf@ti.com>
Message-ID: <21ea20875f7380e0987b118cc4b3ac28@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

[....]
> > I pulled your latest pm-core branch
> > ------
> > commit 61cbb3172176b84c106bf0f4c32317c472932ab5
> > Merge: d0cf394... da19719...
> > Author: Kevin Hilman <khilman@ti.com>
> > Date:   Wed Mar 23 16:33:01 2011 -0700
> >
> >     Merge branch 'for_2.6.40/pm-misc' into pm-reset
> > -----------------
> > Looks like Russell's devel branch isn't merged in pm-core.
> > I didn't find the relevant patches.
>
> hmm, you're right.  I'm actually pulling Russell's devel-stable
> branch
> not his devel branch.  I assumed they were in devel-stable as well.
>
Ok.

> > By the way the relevant ARM patches are already in mainline.
> > So if the pm-core is rebased against latest mainline, we can get
> > those changes as well.
>
> Before I rebase, I'll wait at least until -rc1 and/or Tony rebases
> to mainline.
>
Ok.

> In the mean time, can you create two branches?  One with the
> dependencies and another with the OMAP4 PM series.  After some final
> review and testing, I'll merge the latter series and by then we'll
> probably have an -rc1 baseline.
>
Will do.

Regards,
Santosh
