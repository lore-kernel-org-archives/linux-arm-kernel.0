From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Oct 2015 07:47:07 -0700
Subject: [BISECTED] Nokia 770 framebuffer breakage
In-Reply-To: <20151020085003.GA16268@blackmetal.musicnaut.iki.fi>
References: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
 <20151019200522.GJ32536@n2100.arm.linux.org.uk>
 <20151019222413.GG31069@blackmetal.musicnaut.iki.fi>
 <20151019225033.GK32536@n2100.arm.linux.org.uk>
 <20151020085003.GA16268@blackmetal.musicnaut.iki.fi>
Message-ID: <20151020144707.GA3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Aaro Koskinen <aaro.koskinen@iki.fi> [151020 01:51]:
> 
> With newer kernels and this fix the kernel now hangs during FB
> initialization. I tried to bisect it and it seemed to point to OMAP1
> sparse IRQ changes. Unfortunately those are difficult to test because
> e.g. commit 685e2d08c54b1a1bf31bbe6562f06db089d31c7b does not seem to
> compile without some other changes...

If you need to bisect just the omap1 sparse irq changes, maybe you can
do it between v4.1-rc3..685e2d08c54b1 plus your extra patch carried.


Regards,

Tony
