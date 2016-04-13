From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Apr 2016 08:15:27 -0700
Subject: Nokia N900 retention mode in v4.6, camera buttons fun
In-Reply-To: <570DDE9C.10504@ti.com>
References: <20160407213229.GO16484@atomide.com> <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com> <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd> <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd> <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com> <570DDE9C.10504@ti.com>
Message-ID: <20160413151526.GO5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [160412 22:53]:
> 
> On 12/04/16 19:30, Tony Lindgren wrote:
> 
> > With LCD enabled, both LEDs are on contantly. I think we should
> > be able to hit retention in that state, at least n950 is doing it
> > with the Nokia kernel.
> 
> N900's display needs constant updating, where N950's display has
> internal framebuffer, allowing OMAP to be off.

OK, so the results are as expected then.

Regards,

Tony
