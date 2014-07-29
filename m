From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jul 2014 08:28:38 -0700
Subject: [PATCH 30/35] irqchip: add irq-omap-intc.h header
In-Reply-To: <20140729151936.GC17808@saruman.home>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-31-git-send-email-balbi@ti.com>
 <20140729120133.GQ29045@atomide.com>
 <20140729141045.GA17808@saruman.home>
 <20140729150655.GU29045@atomide.com>
 <20140729151936.GC17808@saruman.home>
Message-ID: <20140729152838.GW29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140729 08:22]:
> On Tue, Jul 29, 2014 at 08:06:55AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [140729 07:13]:
> > > This is the third time I rebase the series after a long hiatus and it
> > > always comes out to the same result -> "let's wait some more".
> > 
> > Nope, it's always been "this series causes PM regressions"
> 
> you just said that we haven't been in any position to really test this,
> so can it be that the status has always been "this series causes PM
> regressions". We couldn't test that before, right ?

It's been working for legacy booting for years with the mainline
kernel, but not for device tree based booting until with v3.16-rc4.
I believe I tested your earlier series with my pending DT patches
though.
 
> > and few other minor comments. And we have not been in any
> > position to really test that until with v3.16-rc4. And then
> > you always run out of time and nobody else does anything :)
> 
> sure, I have other stuff to do as well.

Right :) I and others can provide some help here, but it's
the mr. patch author that needs to follow up on this series
too :p

Regards,

Tony
