From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Wed, 14 Nov 2012 06:49:58 +0000
Subject: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
In-Reply-To: <20121114062117.GC7407@opensource.wolfsonmicro.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com> <5097F078.50701@ti.com>
 <20121114022341.GM4415@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA6B043@DBDE01.ent.ti.com>
 <20121114062117.GC7407@opensource.wolfsonmicro.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA6B0AF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 11:51:19, Mark Brown wrote:
> On Wed, Nov 14, 2012 at 06:11:45AM +0000, AnilKumar, Chimata wrote:
> 
> > From these two threads we can infer that this is handled in power_off
> > sequence only. And this is feature of PMIC to go to shutdown mode nothing
> > to be fixed in silicon. PWR_EN line can be connected to any of these like
> > PRCM control or GPIO or some other instead of RTC(in this case).
> 
> OK, but why are you telling me this?  What are you looking for me to do
> with this information?
> 

Mark,

Earlier you have a comment on this thread, I am adding my comments
on top of it. Sorry if I am in wrong direction.

Thanks
AnilKumar
