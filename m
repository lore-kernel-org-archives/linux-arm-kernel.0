From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2012 10:12:41 -0700
Subject: [PATCH 04/29] ARM: OMAP1: Move board-ams-delta.h from plat to mach
In-Reply-To: <20120920011630.GB17666@opensource.wolfsonmicro.com>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210543.28074.10214.stgit@muffinssi>
 <20120920011630.GB17666@opensource.wolfsonmicro.com>
Message-ID: <20120920171134.GB28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120919 19:05]:
> On Wed, Sep 19, 2012 at 02:05:43PM -0700, Tony Lindgren wrote:
> > This is only used by omap1.
> > 
> > And to fix things properly, this should not be included
> > from the drivers at all.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> or I can apply it if that's easier.

Thanks I'll do a series for Arnd on top of the multiplatform
changes to avoid more merge conflicts.

Regards,

Tony
