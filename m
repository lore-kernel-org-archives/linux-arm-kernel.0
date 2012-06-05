From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Jun 2012 00:50:41 -0700
Subject: [RESUBMIT PATCH] ARM: OMAP2+: am33xx: Add low level debugging
 support
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA39248@DBDE01.ent.ti.com>
References: <1336639981-27194-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA39248@DBDE01.ent.ti.com>
Message-ID: <20120605075040.GG12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120528 23:17]:
> On Thu, May 10, 2012 at 14:23:01, Hiremath, Vaibhav wrote:
> > From: Afzal Mohammed <afzal@ti.com>
> > 
> > Add support for low level debugging on AM335X EVM (AM33XX family).
> > Currently only support for UART1 console, which is used on AM335X EVM
> > is added.
> > 
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> > This patch had been Reviewed and accepted earlier, but got
> > missed during last merge window. Resubmitting again, without
> > code-change.
> > 
> >  arch/arm/mach-omap2/include/mach/debug-macro.S |   17 ++++++++++++++++-
> >  arch/arm/plat-omap/include/plat/serial.h       |    4 ++++
> >  arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++++
> >  3 files changed, 26 insertions(+), 1 deletions(-)
> > 
> 
> Tony,
> 
> Can this be merged now???

Yes applying into devel-am33xx branch.

Regards,

Tony
