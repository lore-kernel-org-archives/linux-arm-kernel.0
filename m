From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Sep 2017 10:51:54 -0700
Subject: [PATCH 01/10] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
In-Reply-To: <20170927095646.fi4l7jbbvrubfe25@squirrel.local>
References: <20170920224621.16236-1-tony@atomide.com>
 <20170920224621.16236-2-tony@atomide.com>
 <20170925063545.nn3gr5drea6o2g6m@squirrel.local>
 <20170925142520.GE4394@atomide.com>
 <20170925172120.xu6k3leg4ac6mjya@squirrel.local>
 <20170925174413.GH4394@atomide.com>
 <20170927095646.fi4l7jbbvrubfe25@squirrel.local>
Message-ID: <20170929175153.GJ4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [170927 02:57]:
> On Mon, Sep 25, 2017 at 10:44:14AM -0700, Tony Lindgren wrote:
> > * Matthijs van Duin <matthijsvanduin@gmail.com> [170925 10:22]:
> > > Ah... three "foreign" modules with an idlemode carelessly thrown into a
> > > register without care for existing layouts.  I think these are more just
> > > exceptional cases which happen to agree by coincidence since they all
> > > just added idlemode in the simplest way possible, but I can understand
> > > how it came to be viewed as a standard type.
> > 
> > So we shall then name this fine centauroid sysc ti,81xx-sysc?
> 
> There's nothing centauroid specific about this, mcasp on omap4 has it too.

OK and for that we have ti,sysc-mcasp. We can call the generic one
ti,sysc-omap4-simple.

Regards,

Tony
