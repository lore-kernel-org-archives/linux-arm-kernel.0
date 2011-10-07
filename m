From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Oct 2011 07:55:58 -0700
Subject: [PATCH 4/4] ARM: OMAP: Map SRAM later on with ioremap_exec()
In-Reply-To: <4E8EA1A1.5070508@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<20111005004546.26980.31836.stgit@kaulin.local>
	<alpine.LFD.2.02.1110042107230.9106@xanadu.home>
	<20111005221320.GE6324@atomide.com> <4E8EA1A1.5070508@ti.com>
Message-ID: <20111007145558.GH6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111006 23:18]:
> 
> Are you considering this change for 3.2?

I think we should as this is blocking development for
generic map_io and genalloc changes for SRAM code.

> OMAP4 errata WA would have a conflict with the
> change is sram code and hence the question ?

Right, let's see if we can fix that with a static mapping.

Regards,

Tony
