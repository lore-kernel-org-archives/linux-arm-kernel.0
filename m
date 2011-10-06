From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Oct 2011 18:42:19 -0700
Subject: [PATCH 0/4] initialize omap SRAM later on with
	__arm_ioremap_exec()
In-Reply-To: <4E8C0125.1060300@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<4E8C0125.1060300@ti.com>
Message-ID: <20111006014219.GH6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111004 23:29]:
> 
> Will look at this series in next couple of days and do some testing.

Thanks, turns out there were a few issues with early ioremap
that I fixed. Care to check the L4_IO_ADDRESS changes?

It's all pushed now into sram-map-io branch at:

https://github.com/tmlind/linux/tree/sram-map-io

It seems it's booting now on all omaps I've tried, so will merge
it into linux-omap master branch as well for testing.

> Looks like you wanted to inlcude below patch also part of this
> series though [PATCH 5/4] numbering is bit confusing.
> [PATCH 5/4] ARM: OMAP: Move set_globals initialization to happen in
> init_early

Yeah sorry the patches overflowed from the initial four..

Regards,

Tony
