From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 May 2010 08:43:43 -0700
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C558B316@dbde02.ent.ti.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100505150209.GC2606@n2100.arm.linux.org.uk>
	<20100513174023.GB13001@n2100.arm.linux.org.uk>
	<20100513211951.GH3428@atomide.com>
	<20100513215825.GC13001@n2100.arm.linux.org.uk>
	<20100513220139.GO3428@atomide.com>
	<20100513221229.GD13001@n2100.arm.linux.org.uk>
	<20100514152208.GU3428@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C558B316@dbde02.ent.ti.com>
Message-ID: <20100514154343.GX3428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100514 08:28]:
> > 
> > Yeah, that missing patch was it. Compiles and boots now:
> > 
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Did you get the frame buffer with lmb ??

I've never gotten a DSS2 frame buffer yet with the code that's
in omap for-next, but I believe Tomi has the missing pieces queued up.

My tested-by was for the patch not breaking the current behaviour,
basically to make sure things boot. So since it's really half
tested, maybe acked-by would be more suitable.

Regards,

Tony
