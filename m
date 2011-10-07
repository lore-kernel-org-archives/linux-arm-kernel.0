From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Oct 2011 07:45:10 -0700
Subject: [PATCH 0/4] initialize omap SRAM later on with
	__arm_ioremap_exec()
In-Reply-To: <4E8EA35E.6050100@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<4E8C0125.1060300@ti.com> <20111006014219.GH6324@atomide.com>
	<4E8EA35E.6050100@ti.com>
Message-ID: <20111007144510.GF6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111006 23:25]:
> On Thursday 06 October 2011 07:12 AM, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [111004 23:29]:
> >>
> >> Will look at this series in next couple of days and do some testing.
> > 
> > Thanks, turns out there were a few issues with early ioremap
> > that I fixed. Care to check the L4_IO_ADDRESS changes?
> >
> They look ok to me.

Thanks for testing.
 
> > It's all pushed now into sram-map-io branch at:
> > 
> > https://github.com/tmlind/linux/tree/sram-map-io
> > 
> > It seems it's booting now on all omaps I've tried, so will merge
> > it into linux-omap master branch as well for testing.
> > 
> I have reviewed and tested this series. No problems seen.
> As asked on other thread, if you are targeting this one for
> 3.2, then sram changes would have a small conflict with
> OMAP4 errata patch. If it is for 3.3, we should be able to
> sort out that conflict easily.

Yeah let's if we can map the errata fix page separately.

Regards,

Tony
