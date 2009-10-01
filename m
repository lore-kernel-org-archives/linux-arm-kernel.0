From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 1 Oct 2009 10:07:17 +0200
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <20091001090444.560b2e0a@marrow.netinsight.se>
References: <200910010904.18923.dk-arm-linux@gmx.de>
	<20091001090444.560b2e0a@marrow.netinsight.se>
Message-ID: <200910011007.17429.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 01 Oktober 2009 09:04:44 schrieb Simon Kagstrom:
> On Thu, 1 Oct 2009 09:04:18 +0200
> Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> 
> > hm - it seems to be suspect but I've got random kernel crashes with latest openrd git kernel from:
> > 
> > http://repo.or.cz/w/linux-2.6/linux-2.6-openrd.git
> > (BTW: are there any news on bringing the openrd kernel to mainline?)
> > 
> > It looks like there is something wrong in cpu_idle()???
> 
> Try starting with openocd disconnected (i.e., the openocd program
> suspended or terminated). I also get random crashes when that is on,
> presumably caused by it stopping and resuming the kernel randomly (you
> can see that in the openocd terminal window).
> 

:)
It looks like this was the real reason!
I've spent hours of sorting out what causes the crashes but now it's clear why it is almost random
and not depending on my kernel configuration!

Many thanks,
Dieter


> // Simon
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
