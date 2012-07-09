From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Jul 2012 09:33:36 +0200
Subject: [PATCH 0/7] Convert mxs board files to device tree
In-Reply-To: <201207090933.14110.marex@denx.de>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <20120709071326.GC11635@S2101-09.ap.freescale.net>
 <201207090933.14110.marex@denx.de>
Message-ID: <201207090933.37010.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek Vasut,

> Dear Shawn Guo,
> 
> > On Mon, Jul 09, 2012 at 09:04:52AM +0200, Marek Vasut wrote:
> > > I can send you updated file, but it contains some additional cruft --
> > > especially the SPI and i2c stuff. But then, I guess it just won't be
> > > probed, right ?
> > 
> > Yes.  That should not be a problem.  But we need to make sure the
> > bindings will stay unchanged till hitting the mainline.
> 
> Correct, so merge this and I'll update it when it's in place.

And enable enet_out

> Best regards,
> Marek Vasut

Best regards,
Marek Vasut
