From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 12 Feb 2014 01:21:38 +0100
Subject: [PATCH] ARM: SAMSUNG: remove obsolete tick.h
In-Reply-To: <093801cf0ddc$6f8fe060$4eafa120$@kernel.org>
References: <1907750.XQ1uIOEDlS@phil>
 <093801cf0ddc$6f8fe060$4eafa120$@kernel.org>
Message-ID: <1570984.izKrWRrZLR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 10. Januar 2014, 17:17:43 schrieb kgene at kernel.org:
> Heiko St?bner wrote:
> > Commit 48cf83dc12f2 (ARM: samsung: remove unused tick.h) removed some
> > occurences of tick.h. tick.h itself and s3c24xx_ostimer_pending was only
> > used by the old timer driver and is not used anymore.
> > 
> > Therefore remove the last 3 occurences.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  arch/arm/mach-s3c24xx/include/mach/tick.h |   15 --------------
> >  arch/arm/mach-s3c64xx/include/mach/tick.h |   31
> 
> -------------------------
> 
> > ----
> > 
> >  arch/arm/mach-s5pc100/include/mach/tick.h |   31
> 
> -------------------------
> 
> > ----
> > 
> >  3 files changed, 77 deletions(-)
> >  delete mode 100644 arch/arm/mach-s3c24xx/include/mach/tick.h
> >  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/tick.h
> >  delete mode 100644 arch/arm/mach-s5pc100/include/mach/tick.h
> 
> Nice cleanup :-)
> 
> Applied, thanks,

did this make its way into your tree? Because as of now I can't see it in the 
linux-samsung.git.


Thanks
Heiko
