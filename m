From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 07 Oct 2011 16:23:45 -0400 (EDT)
Subject: [PATCH 0/4] initialize omap SRAM later on with
	__arm_ioremap_exec()
In-Reply-To: <4E8EA35E.6050100@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<4E8C0125.1060300@ti.com> <20111006014219.GH6324@atomide.com>
	<4E8EA35E.6050100@ti.com>
Message-ID: <alpine.LFD.2.02.1110071622090.6390@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Oct 2011, Santosh Shilimkar wrote:

> I have reviewed and tested this series. No problems seen.
> As asked on other thread, if you are targeting this one for
> 3.2, then sram changes would have a small conflict with
> OMAP4 errata patch. If it is for 3.3, we should be able to
> sort out that conflict easily.

3.2 please.  I've postponed one of my series to 3.3 because it breaks 
OMAP unless those changes are applied first.


Nicolas
