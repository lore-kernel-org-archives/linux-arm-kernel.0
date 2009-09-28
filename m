From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Mon, 28 Sep 2009 13:45:17 -0700
Subject: [PATCH] ARM: includecheck fix: mach-bcmring, core.c
In-Reply-To: <1253625100.3784.10.camel@ht.satnam>
References: <1253623861.3784.4.camel@ht.satnam>
	<1253625100.3784.10.camel@ht.satnam>
Message-ID: <20090928204517.GD30661@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jaswinder,

Huang Weiyi had submitted the same patch last week.
It's been submitted to Russell already.

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5732/1

Thanks anyway,

On Tue, Sep 22, 2009 at 06:11:40AM -0700, Jaswinder Singh Rajput wrote:
> Cc to linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
> 
> On Tue, 2009-09-22 at 18:21 +0530, Jaswinder Singh Rajput wrote:
> > fix the following 'make includecheck' warning:
> > 
> >   arch/arm/mach-bcmring/core.c: linux/amba/bus.h is included more than once.
> > 
> > Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> > ---
 

-- 

Leo Hao Chen

------------------------
Life is short, run long.
