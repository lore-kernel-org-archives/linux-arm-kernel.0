From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Mar 2014 09:19:29 -0800
Subject: [PATCH 0/8] OMAP: OMAP3 DSS related clock patches
In-Reply-To: <531709C2.6080607@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
 <5316E1B6.4060007@ti.com> <5316F895.30607@ti.com>
 <531709C2.6080607@ti.com>
Message-ID: <20140305171929.GE4983@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140305 03:28]:
> On 05/03/14 12:12, Tero Kristo wrote:
> > On 03/05/2014 10:35 AM, Tomi Valkeinen wrote:
> >> Hi Tero,
> >>
> >> What about the dts fixes in this series? DSS DT depends on those fixes.
> >> I'd like the dts fixes to be either merged for v3.14, or I can add them
> >> to my DSS DT series (with acks).
> > 
> > Well, I am not a maintainer of any sort, so you are asking wrong person
> > here. I am just tossing my acks around as my approval for the patches in
> > case someone cares. :) You need to ask Benoit here (or maybe Tony.)
> 
> Ok.
> 
> Benoit, Tony, can we get the dts fixes in this series to v3.14, or is it
> ok if I merge them via DSS DT branch for 3.15?

It's best that you take those four dts changes into your DSS branch.
They don't seem to conflict with anything I have queued, so:

Acked-by: Tony Lindgren <tony@atomide.com>
